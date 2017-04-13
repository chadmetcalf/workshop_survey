# frozen_string_literal: true
class ApplicationController < ActionController::Base
  include Clearance::Controller
  protect_from_forgery with: :exception

  def current_user
    @_current_user ||= User.new
  end

  def reset_surveys
    cookies.delete(:four_week_feedback_session, domain: 'msts-workshops.herokuapp.com')
    cookies.delete(:workshop_registration, domain: 'msts-workshops.herokuapp.com')
  end
end
