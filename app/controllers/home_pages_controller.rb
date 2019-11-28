class HomePagesController < ApplicationController
  def index
    @decks = current_user.decks
  end
end
