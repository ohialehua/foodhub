class ApplicationMailer < ActionMailer::Base
  default from: 'ENV["SECRET_EMAIL"]'
  layout 'mailer'
end
