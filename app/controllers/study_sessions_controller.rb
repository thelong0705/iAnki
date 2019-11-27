class StudySessionsController < ApplicationController
  before_action :set_card
  def show

  end

  def edit
  end

  def update
  end

  private
    def set_card
      @deck = Deck.find(params[:id])
      @card = Card.find(@deck.cards.not_remembered.pluck(:id).sample)
    end
end
