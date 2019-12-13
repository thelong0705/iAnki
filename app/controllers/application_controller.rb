class ApplicationController < ActionController::Base
  around_action :switch_locale
  include SessionsHelper

  def switch_locale(&action)
    locale = current_user.try(:locale) || params[:locale] || cookies[:locale]
    locale = I18n.default_locale if locale.blank?
    I18n.with_locale(locale, &action)
  end
end
