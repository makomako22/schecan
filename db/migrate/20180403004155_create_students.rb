class CreateStudents < ActiveRecord::Migration
  def change
    create_table :students do |t|
      t.integer :term
      t.string  :family_name
      t.string  :first_name
      t.string  :family_name_kana
      t.string  :first_name_kana
      t.text    :sheet
      t.timestamps
    end
  end
end
