class CreateSchedules < ActiveRecord::Migration
  def change
    create_table :schedules do |t|
      t.integer   :student_id
      t.datetime  :schedule_at
      t.string    :mentor
      t.text      :memo
      t.timestamps
    end
  end
end
