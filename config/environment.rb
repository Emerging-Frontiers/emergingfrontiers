# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Rails.application.initialize!
ActionMailer::Base.delivery_method = :smtp

ActionMailer::Base.smtp_settings = {
   :address => "smtp.sendgrid.net",
   :port => 587,
   :domain => "emergingfrontiers.com/",
   :authentication => :plain,
   :user_name => "gujaratholidays",
   :password => "gauravgarg",
   :enable_starttls_auto => true
}