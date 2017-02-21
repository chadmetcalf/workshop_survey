module Admin
  class SurveysController < ApplicationController
    before_action :require_login

    def index
      @surveys = Survey.has_user.valid
    end

    def survey_params
      params.require(:survey).permit!
    end
  end
end
