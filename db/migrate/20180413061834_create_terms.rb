class CreateTerms < ActiveRecord::Migration
  def change
    create_table :terms do |t|
      t.integer  :term_i
      t.string   :term_t
      t.timestamps
    end
  end
end
