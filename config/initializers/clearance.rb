Clearance.configure do |config|
  config.mailer_sender = 'no-reply@multiservice.com'
  config.rotate_csrf_on_sign_in = false
  config.allow_sign_up = false
  config.user_model = AdminUser
end
