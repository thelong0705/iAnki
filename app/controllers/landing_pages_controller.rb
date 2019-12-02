class LandingPagesController < ApplicationController
  def index
    redirect_to home_url if current_user
    @decks = Deck.first(9)
  end
end
