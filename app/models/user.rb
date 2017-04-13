class User < ApplicationRecord
  has_many :surveys

  has_one :workshop_registration
  has_one :four_week_feedback

  def taken_both?
    workshop_registration && four_week_feedback
  end

end
