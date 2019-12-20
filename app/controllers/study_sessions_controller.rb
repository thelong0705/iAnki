class StudySessionsController < ApplicationController
  before_action :find_deck
  before_action :check_public_or_owner

  def show
    if current_user
      unique_id = current_user.id
    else
      session[:unique_id] ||= Time.now.to_i
      unique_id = session[:unique_id]
    end

    @study_session = StudySession.find_by(deck_id: @deck.id, unique_id: unique_id)
    unless @study_session
      now = Time.now
      @study_session = StudySession.create(deck_id: @deck.id, unique_id: unique_id)
      array_to_insert = @deck.cards.reduce([]) do |array, card|
        array.push({study_session_id: @study_session.id, card_id: card.id, created_at: now, updated_at: now})
      end
      StudySessionCard.insert_all array_to_insert
    end
    set_card @study_session
  end


  def update
    if current_user
      unique_id = current_user.id
    else
      unique_id = session[:unique_id]
    end

    @study_session = StudySession.find_by(deck_id: @deck.id, unique_id: unique_id)

    if params[:commit] == 'study_again'
      @study_session.study_session_cards.find_by(card_id: params[:card_id]).update(is_showed: true)
    end

    if params[:commit] == 'got_it'
      @study_session.study_session_cards.find_by(card_id: params[:card_id]).delete
    end

    if params[:commit] == 'learn_again'
      @study_session.destroy
      redirect_to study_session_path(@deck)
      return
    end

    set_card @study_session
  end

  private

  def set_card(study_session)
    @card = study_session.study_session_cards.not_have_showed.sample.try(:card)

    unless @card
      @card = study_session.study_session_cards.have_showed.sample.try(:card)
    end
  end

  def find_deck
    @deck = Deck.find_by(id: params[:id])
    render_404 unless @deck
  end

  def check_public_or_owner
    unless @deck.is_public || @deck.user == current_user
      render_404
    end
  end
end
