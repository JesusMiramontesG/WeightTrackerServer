class AddExactWeightToWeightTracker < ActiveRecord::Migration[5.0]
  def change
      add_column :weight_entries, :exact_weight, :float
  end
end
