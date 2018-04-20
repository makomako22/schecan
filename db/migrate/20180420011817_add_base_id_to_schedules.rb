class AddBaseIdToSchedules < ActiveRecord::Migration
  def change
    add_column :schedules, :base_id, :integer
  end
end
