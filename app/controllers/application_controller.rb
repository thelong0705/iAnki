class ApplicationController < ActionController::Base
  around_action :switch_locale
  include SessionsHelper

  def switch_locale(&action)
    locale = current_user.try(:locale) || params[:user].try(:[], :locale) ||  params[:locale] || I18n.default_locale
    I18n.with_locale(locale, &action)
  end
end
