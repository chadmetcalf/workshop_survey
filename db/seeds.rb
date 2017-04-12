# frozen_string_literal: true
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Rails.logger.info 'Seeding Database'
AdminUser.find_or_create_by(email: ENV.fetch('DEVELOPMENT_USERNAME')) do |u|
  u.password = ENV.fetch('DEVELOPMENT_PASSWORD')
end

require 'faker'

100.times do
  User.create(email: Faker::Internet.safe_email('Nancy'),
              name: Faker::Name.name)
end

# Make sure that there is at least one of each type of survey in the database
%w(WorkshopRegistration FourWeekFeedback Null).each do |survey_type|
  Survey.find_or_create_by(active: false, type: survey_type)
end

30.times do
  data = WorkshopRegistration.baseline_questions.keys.each_with_object({}) { |k, acc| acc[k] = rand(5)+1 }
  WorkshopRegistration.create(user: User.all.sample, data: data, finished_at: Time.now.utc)
end

30.times do
  data = { baseline: { ci: rand(5)+1,
                       refactor: rand(5)+1,
                       twelve_factor: rand(5)+1,
                       benchmark: rand(5)+1,
                       authn: rand(5)+1,
                       pci: rand(5)+1 },
           value: 'Yes',
           impact: 'No',
           group_size: 'ewfdsf saf asd',
           learning_culture: 'sdg saf sadf dfs',
           time_commitment: 'dsaf dsf  dsaf asdf' }
  FourWeekFeedback.create(user: User.all.sample, data: data, finished_at: Time.now.utc)
end
