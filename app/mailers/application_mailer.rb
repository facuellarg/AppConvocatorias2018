class ApplicationMailer < ActionMailer::Base
  default from: 'ifreelanceapp@gmail.com'
  layout 'mailer'
  
  def change_state(application)
    @application = application

    mail to: @application.user.email
  end
end
