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
      flash[:success] = t 'check_your_email'
      UserMailer.password_reset(@user).deliver_later
      redirect_to redirect_url
    else
      flash.now[:error] = t 'email_not_found'
      respond_to do |format|
        format.js
      end
    end
  end

  def edit
  end

  def update
    if params[:user][:password].empty?
      render 'edit'
    elsif @user.update_attributes(user_params) 
      log_in @user
      redirect_to @user
    else
      render 'edit'
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
      unless (@user && @user.activated? && @user.authenticated?(:reset, params[:id]))
        redirect_to root_url
      end
    end

    def check_expiration
      if @user.password_reset_expired?
        redirect_to new_password_reset_url
      end
    end
end
