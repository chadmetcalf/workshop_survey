class SurveysController < ApplicationController
  def index
  end

  def create
    @user = User.find_or_create_by(email: survey_params[:email])
    @survey = Survey.create(user: @user, data: survey_params[:data], finished_at: Time.now.utc)
  end

  def survey_params
    params.require(:survey).permit!
  end
end
