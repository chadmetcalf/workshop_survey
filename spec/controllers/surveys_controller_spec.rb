# frozen_string_literal: true
require 'rails_helper'

RSpec.describe SurveysController, type: :controller do
  it 'should have a current_user' do
    expect(subject.current_user).to_not eq(nil)
  end

  it 'should get new' do
    get 'new'
    expect(response).to be_success
  end
end
