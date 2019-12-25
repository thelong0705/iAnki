class UsersController < ApplicationController
  before_action :required_login, except: [:show, :create]
  before_action :find_user, only: [:show, :edit, :update]
  before_action :check_auth, only: [:edit, :update]

  def show
    @learning_decks = Deck.where(id: StudySession.where(unique_id: @user.id).pluck(:deck_id))
  end

  def edit
  end

  def update
    @user.update(user_params)
    flash[:info]= t(:updated)
    redirect_to edit_user_url(current_user)
  end

  def create
    @user = User.new(user_params)

    if @user.save
      UserMailer.account_activation(@user, @user.activation_token).deliver_now
      flash.now[:info] = t 'check_your_email'
    end
    respond_to do |format|
      format.js
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation,
                                 :locale, :image, :new_cards_per_day, :old_cards_per_day)
  end

  def required_login
    unless current_user
      redirect_url = I18n.locale == I18n.default_locale ? root_url : landing_url(:jp)
      flash[:warning] = t :please_login
      redirect_to redirect_url
    end
  end

  def check_auth
    unless current_user.id == params[:id].to_i
      flash[:warning] = t :not_authenticated
      redirect_to home_url
    end
  end

  def find_user
    @user = User.find_by(id: params[:id])
    render_404 unless @user
  end
end
