class AddCheckboxToSchedules < ActiveRecord::Migration
  def change
    add_column :schedules, :checkbox, :boolean
  end
end
