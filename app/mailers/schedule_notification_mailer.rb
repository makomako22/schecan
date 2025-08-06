class ScheduleNotificationMailer < ActionMailer::Base
  default from: 'noreply@schecan.com'

  def notification_email(schedule)
    @schedule = schedule
    @student = schedule.student
    @base = schedule.base
    @mentor = schedule.mentor
    @schedule_time = schedule.schedule_at.strftime('%Y年%m月%d日 %H:%M')
    
    # For now, we'll send to the mentor - in a real application, 
    # this might be sent to student or multiple recipients
    mail(
      to: "#{@mentor}@example.com", # This would need to be configured with real emails
      subject: "【スケジュール通知】#{@student.family_name} #{@student.first_name}さんの面談が30分後に開始されます"
    )
  end
end