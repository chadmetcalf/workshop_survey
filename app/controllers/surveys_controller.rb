class SurveysController < ApplicationController
  def index
    reset_cookies
    @surveys = Survey.types
  end

  def new
    @survey = new_survey.process
    @survey_types_not_taken = new_survey.survey_types_not_taken
  end

  def create
    @_current_user = User.find_or_initialize_by(email: survey_params[:email], name: survey_params[:name])

    @survey = Survey.create!(type: survey_params[:type], user: @user, data: data_params, finished_at: Time.now.utc)
  end

  def new_survey
    @_new_survey ||= NewSurveyService.new(params: params, cookies: cookies, user: current_user)
  end

  def data_params
    survey_params.slice *survey_params[:type].constantize.data_param_keys
  end

  def survey_params
    params.require(:survey).permit!
  end
end
