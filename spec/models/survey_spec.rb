# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Survey, type: :model do
  it 'builds a matrix question for survey.js' do
    expect( Survey.surveyjs_matrix_questions )
      .to include(Hash['value': Survey::QUESTIONS.keys.first.to_s, 'text': Survey::QUESTIONS.values.first])
  end

  it 'provides formated chart data' do
    survey = Survey.new(data: { Survey::QUESTIONS.keys.third => "4", Survey::QUESTIONS.keys.fourth => "3" })
    expect( survey.chart_data ).to eq([0, 0, 4, 3, 0, 0])
  end
end
