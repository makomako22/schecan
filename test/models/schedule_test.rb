require 'test_helper'

class ScheduleTest < ActiveSupport::TestCase
  
  test "should identify schedules needing notification" do
    schedules = Schedule.needing_notification
    assert_includes schedules, schedules(:upcoming_notification)
    assert_not_includes schedules, schedules(:already_notified)
    assert_not_includes schedules, schedules(:past_schedule)
    assert_not_includes schedules, schedules(:future_schedule)
  end

  test "should_send_notification returns true for upcoming unnotified schedule" do
    schedule = schedules(:upcoming_notification)
    assert schedule.should_send_notification?
  end

  test "should_send_notification returns false for already notified schedule" do
    schedule = schedules(:already_notified)
    assert_not schedule.should_send_notification?
  end

  test "should_send_notification returns false for past schedule" do
    schedule = schedules(:past_schedule)
    assert_not schedule.should_send_notification?
  end

  test "should_send_notification returns false for future schedule" do
    schedule = schedules(:future_schedule)
    assert_not schedule.should_send_notification?
  end

  test "send_notification marks schedule as notified" do
    schedule = schedules(:upcoming_notification)
    
    # Stub the mailer to avoid actually sending emails in tests
    ScheduleNotificationMailer.stub :notification_email, mock_delivery do
      assert schedule.send_notification!
      schedule.reload
      assert schedule.notification_sent?
    end
  end

  private

  def mock_delivery
    mock = Minitest::Mock.new
    mock.expect :deliver_now, true
    mock
  end
end
