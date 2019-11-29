class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)
    @user.locale = @user.locale.presence

    if @user.save
      UserMailer.account_activation(@user).deliver_now
      flash.now[:success] = t 'check your email'
    end
    respond_to do |format|
      format.js
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :locale)
  end
end
