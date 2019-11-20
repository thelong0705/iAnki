class SessionsController < ApplicationController
  def create
    @user = User.find_by(email: params[:session][:email])

    respond_to do |format|
      if @user && @user.authenticate(params[:session][:password])
        log_in @user
        format.html { redirect_to @user }
      else
        format.js
      end
    end
  end

  def destroy

  end

end
