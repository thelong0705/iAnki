class LandingPagesController < ApplicationController
  def show
    redirect_to home_url if current_user
  end
end
