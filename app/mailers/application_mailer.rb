class ApplicationMailer < ActionMailer::Base
  default from: '管理人ENV["SECRET_EMAIL"]'
  layout 'mailer'
end
