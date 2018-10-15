class CreateBriefings < ActiveRecord::Migration
  def change
    create_table :briefings do |t|
			t.datetime  :schedule_at
      t.string    :mentor
      t.integer   :base_id
      t.timestamps
    end
  end
end
