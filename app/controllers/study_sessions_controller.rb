class StudySessionsController < ApplicationController
  before_action :set_card, only: :show
  after_action :set_card, only: :update

  def show
  end


  def update
    return if params[:commit] == "Study again"
    last_card = Card.find(params[:card_id])
    last_card.update(is_remembered: true)
  end

  private
    def set_card
      @deck = Deck.find(params[:id])
      random_id = @deck.cards.not_remembered.pluck(:id).sample
      @card = Card.find_by(id: random_id)
    end
end
