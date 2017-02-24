# frozen_string_literal: true
SMTP_SETTINGS = {
  address: ENV.fetch('MAILGUN_SMTP_SERVER'),
  authentication: :plain,
  domain: 'workshop-registration.heroku.com',
  enable_starttls_auto: true,
  password: ENV.fetch('MAILGUN_SMTP_PASSWORD'),
  port: ENV.fetch('MAILGUN_SMTP_PORT'),
  user_name: ENV.fetch('MAILGUN_SMTP_LOGIN')
    authentication: :plain
}.freeze

if ENV['EMAIL_RECIPIENTS'].present?
  Mail.register_interceptor RecipientInterceptor.new(ENV['EMAIL_RECIPIENTS'])
end
