class Schedule < ActiveRecord::Base

  include DatetimeIntegratable

  REGISTRABLE_ATTRIBUTES = %i(
    name
    schedule_at_date schedule_at_time
  )
  integrate_datetime_fields :schedule_at

  validates :schedule_at_date, presence: true
  validates :schedule_at_time, presence: true
  validates :mentor, presence: true
  belongs_to :student

  def get_term(schedule)
    student = Student.find_by(term: schedule.student.term)
    s_term = student.term
    term = Term.find_by(term_i: s_term)
    term.term_t
  end
end

