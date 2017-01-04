class UserProfile < ApplicationRecord

    include Encryption

    belongs_to :user

    attr_encrypted :preferred_units, :key => :encryption_key
    attr_encrypted :height, :key => :encryption_key
    attr_encrypted :gender, :key => :encryption_key
    attr_encrypted :full_name, :key => :encryption_key

    validates :preferred_units, presence: true
    validates :height, presence: true
    validates :gender, presence: true, numericality: true
    validates :full_name, presence: true
    validates :preferred_timezone, presence: true

    def offset_for_timezone
        zone_info = ActiveSupport::TimeZone.find_tzinfo(self.preferred_timezone)
        puts zone_info 
    end
end
