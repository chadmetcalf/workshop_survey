class User < ApplicationRecord
  has_many :surveys

  has_one :workshop_registration
  has_one :four_week_feedback
end
