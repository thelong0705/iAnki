class DecksController < ApplicationController
  def new
    @deck = Deck.new
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
    params.require(:deck).permit(:name)
  end
end
