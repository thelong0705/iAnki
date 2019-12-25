class SearchController < ApplicationController
  def index
    if params[:type] == "users"
      @results = User.search(params[:query])
    elsif params[:type] == "cards"
      @results = Card.search(params[:query])
    else
      @results = Deck.search(params[:query], where: {is_public: true})
    end
  end
end