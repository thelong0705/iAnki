class ApplicationController < ActionController::Base
  around_action :switch_locale
  include SessionsHelper

  def switch_locale(&action)
    locale = current_user.try(:locale) || params[:locale] || cookies[:locale]
    locale = I18n.default_locale if locale.blank?
    I18n.with_locale(locale, &action)
  end

  def required_login
    unless current_user
      redirect_url = I18n.locale == I18n.default_locale ? root_url : landing_url(:jp)
      flash[:warning] = t :please_login
      redirect_to redirect_url
    end
  end

  def render_404
    render :file => 'public/404.html', :status => :not_found, :layout => false
  end

end
