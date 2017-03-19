# frozen_string_literal: true
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

AdminUser.find_or_create_by(email: 'cmetcalf@multiservice.com') do |u|
  u.password = 'test1234'
end

require 'faker'

100.times do
  User.create(email: Faker::Internet.safe_email('Nancy'),
              name: Faker::Name.name)
end

20.times do
  data = {}
  Survey::QUESTIONS.keys.map { |k| data[k] = rand(5)+1 }
  Survey.create(user: User.all.sample, data: data)
end
