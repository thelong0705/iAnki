class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user =  User.find(params[:id])
    @user.update(user_params)
    redirect_to home_url
  end

  def create
    @user = User.new(user_params)

    if @user.save
      UserMailer.account_activation(@user, @user.activation_token).deliver_later
      flash.now[:info] = t 'check_your_email'
    end
    respond_to do |format|
      format.js
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :locale, :image)
  end
end
