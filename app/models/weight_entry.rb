class WeightEntry < ApplicationRecord

    include Encryption
    belongs_to :user

    attr_encrypted :exact_weight, :key => :encryption_key
    attr_encrypted :bmi, :key => :encryption_key

    validates :exact_weight, presence: true, numericality: true
end
