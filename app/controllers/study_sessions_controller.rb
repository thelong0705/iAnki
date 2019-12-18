class StudySessionsController < ApplicationController

  def show
    @deck = Deck.find(params[:id])
    user_id = current_user.id
    @study_session = StudySession.find_by(deck_id: @deck.id, user_id: user_id)
    unless @study_session
      now = Time.now
      @study_session = StudySession.create(deck_id: @deck.id, user_id: user_id)
      array_to_insert = @deck.cards.reduce([]) do |array, card|
        array.push({study_session_id: @study_session.id, card_id: card.id, created_at: now, updated_at: now})
      end
      StudySessionCard.insert_all array_to_insert
    end
    set_card @study_session
  end


  def update
    @deck = Deck.find(params[:id])
    user_id = current_user.id
    @study_session = StudySession.find_by(deck_id: @deck.id, user_id: user_id)

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
end
