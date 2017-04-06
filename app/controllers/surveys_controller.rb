class SurveysController < ApplicationController
  def index
    @surveys = Survey.types
  end

  def new
    @survey = NewSurveyService.process(params: params, cookies: cookies, user: current_user)
  end

  def create
    @_current_user = User.find_or_initialize_by(email: survey_params[:email], name: survey_params[:name])

    @survey = Survey.create!(type: survey_params[:type], user: @user, data: survey_params[:data], finished_at: Time.now.utc)
  end

  def survey_params
    params.require(:survey).permit!
  end
end
