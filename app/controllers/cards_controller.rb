class CardsController < ApplicationController
  def search
    cards_same_question = Card.where(question: params[:keyword]).first(2);
    cards_same_answer = Card.where(answer: params[:keyword]).first(2);

    @suggest_word = cards_same_question.reduce([]) { |a, card| a.push(card.answer)}
    cards_same_answer.reduce(@suggest_word) { |a, card| a.push(card.question)}
    @suggest_word = @suggest_word.uniq
    @card_row_id = params[:id]
    respond_to do |format|
      format.js
    end
  end
end
