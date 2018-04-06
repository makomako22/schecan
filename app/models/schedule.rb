class Schedule < ActiveRecord::Base
  validates :schedule_at, uniqueness: true
  validates :mentor, presence: true
  belongs_to :student
end

