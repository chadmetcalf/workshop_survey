# frozen_string_literal: true
FactoryGirl.define do
  factory :user do
    email "MyString"
    name "MyString"
  end
  factory :survey do
    user ''
    finished_at '2017-02-17 20:31:39'
  end
end
