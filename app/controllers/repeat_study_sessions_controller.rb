class RepeatStudySessionsController < ApplicationController
  before_action :required_login
  before_action :check_auth
  before_action :find_deck

  def show
    @deck = Deck.find(params[:id])
    if @deck.cards.learn_today.empty?
      @deck.cards.unlearn_card.update_all(learn_at: Date.today)
      @deck.cards.review_today.update_all(learn_at: Date.today)
    end

    @card = @deck.cards.learn_today.where(practice_day: [nil, Date.today]).sample
  end

  def update
    answer = params[:commit].to_i
    card = Card.find_by(id: params[:card_id])
    card.repeat_learning(answer)

    @card = @deck.cards.learn_today.where(practice_day: [nil, Date.today]).sample
  end

  private

  def find_deck
    @deck = Deck.find(params[:id])
  end

  def check_auth
    @deck = Deck.find(params[:id])
    unless current_user == @deck.user
      flash[:warning] = t :not_authenticated
      redirect_to home_url
    end
  end
end