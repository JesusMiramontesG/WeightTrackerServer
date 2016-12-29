class AddFullNameToUserProfile < ActiveRecord::Migration[5.0]
  def change
    add_column :user_profiles, :full_name, :string
  end
end
