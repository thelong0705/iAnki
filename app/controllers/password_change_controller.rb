class PasswordChangeController < ApplicationController
  def create
    @user =  User.find(params[:id])
    if BCrypt::Password.new(@user.password_digest) == params[:current_password]
      if @user.update_attributes(password: params[:password], password_confirmation: params[:password_confirmation])
        flash[:info] = t :update_password_success
        redirect_to edit_user_url(current_user)
      else
        respond_to do |format|
          flash.now[:error] = @user.errors.full_messages.first
          format.js { render 'shared/toast'}
        end
      end
    else
      respond_to do |format|
        flash.now[:error] = t :wrong_current_password
        format.js { render 'shared/toast'}
      end
    end
  end
end
