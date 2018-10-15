class Schedule < ActiveRecord::Base

  include DatetimeIntegratable

  REGISTRABLE_ATTRIBUTES = %i(
    schedule_at_date schedule_at_time
  )
  integrate_datetime_fields :schedule_at

  validates_presence_of :schedule_at_date, :schedule_at_time, :mentor, :base_id
  belongs_to :student
  belongs_to :base

  def get_term(schedule)
    student = Student.find_by(term: schedule.student.term)
    s_term = student.term
    term = Term.find_by(term_i: s_term)
    term.term_t
  end

end

