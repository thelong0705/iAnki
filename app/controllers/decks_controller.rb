class DecksController < ApplicationController
  def new
    @deck = Deck.new
    @deck.cards.build
  end

  def create
    @deck = current_user.decks.build(deck_params)
    if @deck.save
      redirect_to root_url
    else
      render 'new'
    end
  end

  def show
    @deck = Deck.find(params[:id])

    respond_to do |format|
      format.html
      format.csv do
        send_data @deck.generate_csv, filename: "#{@deck.name}_#{Time.zone.now.strftime("%Y%m%d")}.csv"
      end
    end
  end

  def edit
    @deck = Deck.find(params[:id])
  end

  def update
    @deck = Deck.find(params[:id])
    @deck.update(deck_params)
    redirect_to @deck
  end

  def import
    cards_attributes = []
    CSV.foreach(params[:file], headers: true) do |row|
      cards_attributes << row.to_hash
    end

    current_user.decks.import_csv(params[:file])
    redirect_to home_url
  end

  private

  def deck_params
    params.require(:deck).permit(:id, :name, cards_attributes: [:id, :question, :answer, :_destroy])
  end
end
