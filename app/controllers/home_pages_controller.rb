class HomePagesController < ApplicationController
  def show
    @decks = current_user.decks
  end
end
