class RepeatStudySessionsController < ApplicationController
  before_action :find_deck

  def show
    @deck = Deck.find(params[:id])
    if @deck.cards.learn_today.empty?
      @deck.cards.unlearn_card.update_all(learn_at: Date.today)
    end
    @card = @deck.cards.learn_today.unlearn_card.sample
  end

  def update
    quality = params[:commit].to_i
    card = Card.find_by(id: params[:card_id])
    card.repeat_learning(quality)
    @card = @deck.cards.learn_today.unlearn_card.sample
  end

  private

  def find_deck
    @deck = Deck.find(params[:id])
  end
end
