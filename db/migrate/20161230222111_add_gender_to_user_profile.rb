class AddGenderToUserProfile < ActiveRecord::Migration[5.0]
  def change
      add_column :user_profiles, :gender, :int, :limit => 2
  end
end
