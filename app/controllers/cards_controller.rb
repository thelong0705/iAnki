class CardsController < ApplicationController
  def search
    #@cards = Card.where("question = ? or answer = ?", "#{params[:keyword]}", "#{params[:keyword]}").first(3)
    @cards = Card.first(3)
    @card_row_id = params[:id]
    respond_to do |format|
      format.js
    end
  end
end
