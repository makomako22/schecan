class AddNotificationSentToSchedules < ActiveRecord::Migration
  def change
    add_column :schedules, :notification_sent, :boolean, default: false
  end
end