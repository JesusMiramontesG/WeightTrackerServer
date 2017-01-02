class AddEncryptedWeightEntryFields < ActiveRecord::Migration[5.0]
    def change
      add_column :weight_entries, :encrypted_exact_weight, :string
      add_column :weight_entries, :encrypted_exact_weight_iv, :string
      add_column :weight_entries, :encrypted_bmi, :string
      add_column :weight_entries, :encrypted_bmi_iv, :string

      if WeightEntry.column_names.include?("exact_weight")
          remove_column(:weight_entries, :exact_weight)
      end

      if WeightEntry.column_names.include?("bmi")
          remove_column(:weight_entries, :bmi)
      end
     
      if WeightEntry.column_names.include?("weight")
          remove_column(:weight_entries, :weight)
      end


    end
end
