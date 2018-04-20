class CreateBases < ActiveRecord::Migration
  def change
    create_table :bases do |t|
      t.string  :name
      t.string  :memo_h
      t.text    :memo
      t.timestamps null: false
    end
  end
end
