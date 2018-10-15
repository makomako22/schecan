class Briefing < ActiveRecord::Base
	include DatetimeIntegratable

  REGISTRABLE_ATTRIBUTES = %i(
    schedule_at_date schedule_at_time
  )
  integrate_datetime_fields :schedule_at

  validates_presence_of :schedule_at_date, :schedule_at_time, :mentor, :base_id
  belongs_to :base
end
