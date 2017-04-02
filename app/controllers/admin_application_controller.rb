# frozen_string_literal: true
class AdminApplicationController < ActionController::Base
  include Clearance::Controller
  protect_from_forgery with: :exception
end
