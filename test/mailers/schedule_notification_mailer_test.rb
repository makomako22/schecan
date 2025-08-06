require 'test_helper'

class ScheduleNotificationMailerTest < ActionMailer::TestCase
  test "notification_email" do
    schedule = schedules(:upcoming_notification)
    email = ScheduleNotificationMailer.notification_email(schedule)

    assert_emails 1 do
      email.deliver_now
    end

    assert_equal ["#{schedule.mentor}@example.com"], email.to
    assert_equal "【スケジュール通知】#{schedule.student.family_name} #{schedule.student.first_name}さんの面談が30分後に開始されます", email.subject
    assert_match schedule.mentor, email.body.to_s
    assert_match schedule.student.family_name, email.body.to_s
    assert_match schedule.student.first_name, email.body.to_s
  end
end