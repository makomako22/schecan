namespace :schedule do
  desc "Send notifications for schedules starting in 30 minutes"
  task send_notifications: :environment do
    puts "Checking for schedules that need notifications..."
    
    schedules_to_notify = Schedule.needing_notification.includes(:student, :base)
    
    if schedules_to_notify.empty?
      puts "No schedules found that need notifications."
    else
      puts "Found #{schedules_to_notify.count} schedule(s) that need notifications."
      
      notification_count = 0
      schedules_to_notify.each do |schedule|
        if schedule.send_notification!
          notification_count += 1
          puts "✓ Sent notification for schedule #{schedule.id} (#{schedule.student.family_name} #{schedule.student.first_name} - #{schedule.schedule_at.strftime('%Y-%m-%d %H:%M')})"
        else
          puts "✗ Failed to send notification for schedule #{schedule.id}"
        end
      end
      
      puts "Successfully sent #{notification_count} notification(s)."
    end
  end
end