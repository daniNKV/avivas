# Preview all emails at http://localhost:3000/rails/mailers/admin/user_mailer
class Admin::UserMailerPreview < ActionMailer::Preview
  # Preview this email at http://localhost:3000/rails/mailers/admin/user_mailer/account_creation
  def account_creation
    Admin::UserMailer.account_creation
  end
end
