module Admin
  class SurveysController < AdminApplicationController
    before_action :require_login

    def index
      @survey_type = params[:type].present? ? params[:type].constantize : Survey
      @surveys = Survey.active.order(:created_at).reverse_order.type(params[:type]).page(params[:page])
    end

    def destroy
      @survey = Survey.find(params[:id])
      @survey.active = false
      if @survey.save
        redirect_to admin_surveys_path, notice: 'Survey successfully removed.'
      else
        redirect_to admin_surveys_path, notice: 'There was an error removing the survey.'
      end
    end

    private

    def survey_params
      params.require(:survey).permit!
    end
  end
end
