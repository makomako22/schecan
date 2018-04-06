class AddDetailToStudents < ActiveRecord::Migration
  def change
    add_column :students, :detail, :string
  end
end
