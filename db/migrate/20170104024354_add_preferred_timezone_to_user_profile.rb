class AddPreferredTimezoneToUserProfile < ActiveRecord::Migration[5.0]
  def change
    add_column :user_profiles, :preferred_timezone, :string
  end
end
