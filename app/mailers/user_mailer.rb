class UserMailer < ApplicationMailer
  def account_activation user
    @greeting = t "hi"
    @user = user
    mail to: user.email, subject: t("account_activation")
  end
end
