class DecksController < ApplicationController
  def new
    @deck = Deck.new
    @deck.cards.build
  end

  def create
    @deck = current_user.decks.build(deck_params)
    if @deck.save
      redirect_to root_url
    else
      render 'new'
    end
  end

  private

  def deck_params
    params.require(:deck).permit(:name, cards_attributes: [:question, :answer])
  end
end
