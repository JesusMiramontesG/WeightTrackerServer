class AddEncryptedUserProfileFields < ActiveRecord::Migration[5.0]
    def change
        add_column :user_profiles, :encrypted_preferred_units, :string
        add_column :user_profiles, :encrypted_preferred_units_iv, :string  
        add_column :user_profiles, :encrypted_height, :string
        add_column :user_profiles, :encrypted_height_iv, :string
        add_column :user_profiles, :encrypted_gender, :string
        add_column :user_profiles, :encrypted_gender_iv, :string
        add_column :user_profiles, :encrypted_full_name, :string
        add_column :user_profiles, :encrypted_full_name_iv, :string

        # drop the old user profile columns if they exist
        if UserProfile.column_names.include?("prefered_units")
            remove_column(:user_profiles, :prefered_units)
        end
        if UserProfile.column_names.include?("height")
            remove_column(:user_profiles, :height)
        end
        if UserProfile.column_names.include?("gender")
            remove_column(:user_profiles, :gender)
        end
        if UserProfile.column_names.include?("full_name")
            remove_column(:user_profiles, :full_name)
        end   
    end
end
