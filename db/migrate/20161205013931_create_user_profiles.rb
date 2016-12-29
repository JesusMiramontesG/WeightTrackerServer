class CreateUserProfiles < ActiveRecord::Migration[5.0]
  def change
    create_table :user_profiles do |t|
      t.references :user, foreign_key: true
      t.integer :prefered_units
      t.integer :height

      t.timestamps
    end
  end
end
