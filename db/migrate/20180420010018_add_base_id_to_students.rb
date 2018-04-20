class AddBaseIdToStudents < ActiveRecord::Migration
  def change
    add_column :students, :base_id, :integer
  end
end
