class UserMailer < ApplicationMailer
  def account_activation(user, activation_token)
    @user = user
    @activation_token = activation_token
    I18n.locale = @user.locale
    mail to: user.email, subject: I18n.t(:account_activation)
  end


  def password_reset(user, reset_token)
    @user = user
    @reset_token = reset_token
    I18n.locale = @user.locale
    mail to: user.email, subject: I18n.t(:password_reset_subject)
  end
end
