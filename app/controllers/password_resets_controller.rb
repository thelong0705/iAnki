class PasswordResetsController < ApplicationController
  before_action :get_user,   only: [:edit, :update]
  before_action :valid_user, only: [:edit, :update]
  before_action :check_expiration, only: [:edit, :update]

  def new
  end

  def create
    @user = User.find_by(email: params[:password_reset][:email])
    if @user
      @user.create_reset_digest
      redirect_url = I18n.locale == I18n.default_locale ? root_url : landing_url(:jp)
      flash[:info] = t 'check_your_password_email'
      UserMailer.password_reset(@user, @user.reset_token).deliver_now
      redirect_to redirect_url
    else
      flash.now[:error] = t 'email_not_found'
      respond_to do |format|
        format.js
      end
    end
  end

  def edit
    if current_user
      flash[:error] = t(:you_are_logged_in)
      redirect_to home_url
    end
  end

  def update
    I18n.locale = @user.locale
    if params[:user][:password].empty?
      respond_to do |format|
        flash.now[:error] = t(:password_cant_be_blank)
        format.js
      end
    elsif @user.update_attributes(user_params) 
      log_in @user
      flash[:info] = t(:update_password_success)
      redirect_to home_url
    else
      respond_to do |format|
        flash.now[:error] = @user.errors.full_messages.first
        format.js
      end
    end
  end

  private

    def user_params
      params.require(:user).permit(:password, :password_confirmation)
    end

    def get_user
      @user = User.find_by(email: params[:email])
    end

    def valid_user
      if not @user
        flash[:error] = t 'email_not_found'
      elsif not @user.activated?
        flash[:error] = t 'not_activated_user'
      elsif not @user.authenticated?(:reset, params[:id])
        flash[:error] = t 'wrong_reset_token'
      end
      redirect_url = params[:locale] == I18n.default_locale ? root_url : landing_url(:jp)
      redirect_to redirect_url if flash[:error]
    end

    def check_expiration
      if @user.password_reset_expired?
        redirect_to new_password_reset_url
      end
    end
end
