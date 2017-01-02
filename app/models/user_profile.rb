class UserProfile < ApplicationRecord

    include Encryption

    belongs_to :user

    attr_encrypted :preferred_units, :key => :encryption_key
    attr_encrypted :height, :key => :encryption_key
    attr_encrypted :gender, :key => :encryption_key
    attr_encrypted :full_name, :key => :encryption_key

end
