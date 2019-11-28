class StudySessionsController < ApplicationController
  before_action :set_card, only: :show

  def show
  end


  def update
    if params[:commit] == "Learn again"
      deck = Deck.find(params[:id])
      deck.cards.update_all is_remembered: false
      redirect_to study_session_path(deck)
    end

    if params[:commit] == "Got it"
      Card.find(params[:card_id]).update(is_remembered: true)
    end

    set_card
  end

  private

  def set_card
    @deck = Deck.find(params[:id])
    random_id = @deck.cards.not_remembered.pluck(:id).sample
    @card = Card.find_by(id: random_id)
  end
end
