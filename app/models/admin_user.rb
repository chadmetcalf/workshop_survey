class AdminUser < ApplicationRecord
  include Clearance::User

  has_many :surveys
end
