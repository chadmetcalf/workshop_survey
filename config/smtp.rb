SMTP_SETTINGS = {
  address: ENV.fetch('POSTMARK_SMTP_SERVER', ''),
  user_name: ENV.fetch('POSTMARK_API_TOKEN', ''),
  password: ENV.fetch('POSTMARK_API_TOKEN', ''),
  domain: ENV['APPLICATION_HOST'],
  port: 25, # or 2525
  authentication: :plain,
  enable_starttls_auto: true
}.freeze

if ENV['EMAIL_RECIPIENTS'].present?
  Mail.register_interceptor RecipientInterceptor.new(ENV['EMAIL_RECIPIENTS'])
end
