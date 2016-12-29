class CreateWeightEntries < ActiveRecord::Migration[5.0]
  def change
    create_table :weight_entries do |t|
      t.references :user, foreign_key: true
      t.integer :weight
      t.integer :bmi

      t.timestamps
    end
  end
end
