class UserMailer < ApplicationMailer
  def account_activation(user, activation_token)
    @user = user
    @activation_token = activation_token
    I18n.locale = @user.locale
    mail to: user.email, subject: I18n.t(:account_activation)
  end


  def password_reset(user)
    @user = user
    I18n.locale = @user.locale
    mail to: user.email, subject: "Password reset"
  end
end
