class WeightEntry < ApplicationRecord
  belongs_to :user

  validates :exact_weight, presence: true, numericality: true
end
