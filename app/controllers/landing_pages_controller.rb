class LandingPagesController < ApplicationController
  def index
    redirect_to home_url if current_user
    @decks = Deck.is_public.last(9)
    I18n.locale = params[:locale] ? params[:locale] : I18n.default_locale
    cookies[:locale] = params[:locale]
  end
end
