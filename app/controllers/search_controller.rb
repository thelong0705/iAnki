class SearchController < ApplicationController
  def index
    if params[:type] == "users"
      @results = User.search(params[:keyword])
    elsif params[:type] == "cards"
      @results = Card.search(params[:keyword])
    else
      @results = Deck.search(params[:keyword])
    end
  end
end



