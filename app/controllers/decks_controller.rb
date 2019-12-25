class DecksController < ApplicationController
  before_action :required_login, except: :show
  before_action :find_deck, only: [:show, :edit, :update, :destroy, :copy]
  before_action :check_auth, only: [:edit, :update, :destroy]

  def new
    @deck = Deck.new
    @deck.cards.build
  end

  def create
    @deck = current_user.decks.build(deck_params)
    if @deck.save
      redirect_to deck_path(@deck)
    else
      respond_to do |format|
        flash.now[:error] = @deck.errors.full_messages.first
        format.js { render 'shared/toast' }
      end
    end
  end

  def show
    unless @deck.is_public || @deck.user == current_user
      render_404
    end
    cards_per_page = 10
    @cards = @deck.cards.page(params[:page]).per(cards_per_page)
    @start_from = params[:page] ? params[:page].to_i : 1
    respond_to do |format|
      format.html
      format.csv do
        send_data @deck.generate_csv, filename: "#{@deck.name}_#{Time.zone.now.strftime("%Y%m%d")}.csv"
      end
    end
  end

  def edit
  end

  def update
    @deck.update(deck_params)
    redirect_to @deck
  end

  def import
    @cards= []
    CSV.foreach(params[:file], headers: true) do |row|
      @cards << row.to_hash
    end

    respond_to do |format|
      format.js
    end
  end

  def destroy
    @deck.destroy
    flash[:info] = t(:delete_successfully)
    redirect_to home_url
  end

  def copy
    if current_user == @deck.user || !@deck.is_public
      flash[:warning] = t :not_authenticated
      redirect_to home_url
    end

    cards_attributes = []
    @deck.cards.each do |card|
      cards_attributes << {question: card.question, answer: card.answer}
    end
    deck = Deck.create!(user: current_user, name: @deck.name, cards_attributes: cards_attributes)
    redirect_to deck
  end

  private

  def deck_params
    params.require(:deck).permit(:id, :name, :page, :is_public, cards_attributes: [:id, :question, :answer, :_destroy])
  end


  def check_auth
    unless current_user == @deck.user
      flash[:warning] = t :not_authenticated
      redirect_to home_url
    end
  end

  def find_deck
    @deck = Deck.find_by(id: params[:id])
    render_404 unless @deck
  end
end
