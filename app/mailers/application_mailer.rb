# frozen_string_literal: true
class ApplicationMailer < ActionMailer::Base
  default from: 'cmetcalf@multiservice.com'
  layout 'mailer'
end
