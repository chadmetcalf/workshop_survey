Clearance.configure do |config|
  config.mailer_sender = 'cmetcalf@multiservice.com'
  config.rotate_csrf_on_sign_in = true
  config.allow_sign_up = false
  config.user_model = AdminUser
end
