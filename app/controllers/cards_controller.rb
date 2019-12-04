class CardsController < ApplicationController
  def search
    @card = Card.find_by(question: params[:keyword])
    @card_row_id = params[:id]
    respond_to do |format|
      format.js
    end
  end
end
