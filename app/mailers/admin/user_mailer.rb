class Admin::UserMailer < ApplicationMailer
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.admin.user_mailer.account_creation.subject
  #
  def account_creation_email
    @user = params[:user]
    @password = params[:password]
    @username = params[:username]

    mail(
      to: @user.email,
      subject: "Your Avivas Administration account has been created just now!"
    )
  end
end
