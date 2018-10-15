class Base < ActiveRecord::Base
  has_many :students, dependent: :destroy
  has_many :schedules, dependent: :destroy
  has_many :briefings, dependent: :destroy
end
