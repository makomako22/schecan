class AddIcebergToStudents < ActiveRecord::Migration
  def change
    add_column :students, :iceberg, :string
  end
end
