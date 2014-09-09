class AppMailer < ActionMailer::Base
  def send_welcome_email(user)
    @user = user
    mail to: user.email, from: "info@tl-flix.com", subject: "Welcome to TL-FLiX!"
  end
end