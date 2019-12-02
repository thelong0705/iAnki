class LandingPagesController < ApplicationController
  def index
    redirect_to home_url if current_user
    @decks = Deck.last(9)
  end
end
