class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.teamjoin.subject
  #

  def account_activation(user)
    @user = user
    mail to: user.email, subject: "Account activation"
  end

  def password_reset(user)
    @user = user
    mail to: user.email, subject: "Password reset"
  end


  def teamjoin(user,team)
    @user = user
    @team = team
    @contest = Contest.find_by(id: @team.contest_id)
    mail to: user.email, subject: "Join Team"
  end
end
