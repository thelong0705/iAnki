class HomePagesController < ApplicationController
  def index
    unless current_user
      redirect_to root_url
      return
    end

    @decks = current_user.decks
  end
end
