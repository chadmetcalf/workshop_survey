require 'csv'

module Admin
  class SurveysController < AdminApplicationController
    before_action :require_login

    def index
      @survey_type = survey_type

      respond_to do |format|
        format.html { @surveys = Survey.active.order(:finished_at).reverse_order.type(params[:type]).page(params[:page]) }
        format.csv { send_data csv_view( Survey.active.order(:finished_at).reverse_order.type(params[:type])) }
      end
    end

    def index_2
      @surveys = Survey.active.order(:created_at).all
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

    def survey_type
      params[:type].try(:safe_constantize) || Survey
    end

    def survey_params
      params.require(:survey).permit!
    end

    def csv_view(surveys)
      CSV.generate do |csv|
        csv.add_row column_names
        surveys.each do |survey|
          csv.add_row survey.csv_row
        end
      end
    end

    def column_names
      ['Type', 'User', 'Finished at', 'Results']
    end
  end
end
