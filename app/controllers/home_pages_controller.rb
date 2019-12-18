class HomePagesController < ApplicationController
  def index
    unless current_user
      redirect_to root_url
      return
    end

    @decks = current_user.decks
    @learning_decks = Deck.where(id: StudySession.where(unique_id: current_user.id).pluck(:deck_id))
  end
end
