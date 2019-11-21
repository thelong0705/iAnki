class SessionsController < ApplicationController
  def create
    @user = User.find_by(email: params[:session][:email])

    respond_to do |format|
      if @user && @user.authenticate(params[:session][:password])
        log_in @user
        remember @user
        format.html { redirect_to home_url }
      else
        format.js
      end
    end
  end

  def destroy
    log_out if current_user
    redirect_to root_url
  end

end
