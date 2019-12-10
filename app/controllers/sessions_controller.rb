class SessionsController < ApplicationController
  def create
    @user = User.find_by(email: params[:session][:email])

    respond_to do |format|
      unless @user
        @errors = {field: "email", message: t(:invalid_email)}
        format.js
        return
      end

      unless @user.activated
        @errors = {field: "email", message: t(:unactivated_email)}
        format.js
        return
      end

      unless @user.authenticate(params[:session][:password])
        @errors = {field: "password", message: t(:invalid_password)}
        format.js
        return
      end

      log_in @user
      remember @user
      format.html { redirect_to home_url }
    end
  end

  def destroy
    log_out if current_user
    redirect_to root_url
  end

end
