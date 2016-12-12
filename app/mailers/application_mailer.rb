class ApplicationMailer < ActionMailer::Base
  default from: 'admin@youp0wn.com'
  default host: 'localhost'
  layout 'mailer'
end
