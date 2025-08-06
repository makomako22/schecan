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

  # Check if notification should be sent (30 minutes before and not already sent)
  def should_send_notification?
    return false if notification_sent?
    return false if schedule_at.nil?
    
    # Check if the schedule is exactly 30 minutes away (with 1 minute tolerance)
    time_until_schedule = (schedule_at - Time.current) / 1.minute
    time_until_schedule >= 29 && time_until_schedule <= 31
  end

  # Send notification and mark as sent
  def send_notification!
    return false unless should_send_notification?
    
    ScheduleNotificationMailer.notification_email(self).deliver_now
    update!(notification_sent: true)
    true
  rescue => e
    Rails.logger.error "Failed to send notification for schedule #{id}: #{e.message}"
    false
  end

  # Class method to find schedules that need notifications
  def self.needing_notification
    where(notification_sent: false)
      .where('schedule_at > ? AND schedule_at <= ?', 29.minutes.from_now, 31.minutes.from_now)
  end

end

