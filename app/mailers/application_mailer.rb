class ApplicationMailer < ActionMailer::Base
  default from: ENV["EMAIL_HIDDEN"]
  layout 'mailer'
end
