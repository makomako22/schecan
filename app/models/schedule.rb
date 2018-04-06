class Schedule < ActiveRecord::Base
  validates :schedule_at, uniqueness: true
  belongs_to :student
end

