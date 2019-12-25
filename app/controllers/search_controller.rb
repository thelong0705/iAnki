class SearchController < ApplicationController
  def index
    if params[:type] == "users"
      @results = User.where("name like ? ", "%#{params[:query]}%")
    elsif params[:type] == "cards"
      @results = Card.where("question like ? or answer like ? ", "%#{params[:query]}%", "%#{params[:query]}%")
    else
      @results = Deck.is_public.where("name like ? ", "%#{params[:query]}%")
    end
  end
end