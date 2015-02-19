class UserMailer < ActionMailer::Base
  include Devise::Mailers::Helpers
  default from: "admin@emergingfrontiers.com"

  def contact_us_email(email,name,subject,message)
    @email = email
    @name = name
    @subject = subject
    @message = message
    mail(from: "visitor@emergingfrontiers.com",to: "info@emergingfrontiers.com",reply_to: @email, subject: "Feedback from website visitor on portal.emergingfrontiers.com")
  end

  # def confirmation_instructions(record,token,options)
  #   devise_mail(record, :confirmation_instructions)
  # end

  # def reset_password_instructions(record,token,options)
  #   devise_mail(record, :reset_password_instructions)
  # end

  def investment_email(investor,investment_opportunity)
    @investor = investor
    @investment_opportunity = investment_opportunity
    mail(from: "visitor@emergingfrontiers.com",to: "info@emergingfrontiers.com",reply_to: @investor.email, subject: "Emerging Frontiers Investment Inquiry")
  end
end
