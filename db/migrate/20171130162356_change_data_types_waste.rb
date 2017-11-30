class ChangeDataTypesWaste < ActiveRecord::Migration[5.0]
  def change
    change_column :waste_contracts, :old_monthly_payment, :float
    change_column :waste_contracts, :cpa_monthly_payment, :float
    change_column :waste_contracts, :contract_start_date, :date
    change_column :waste_contracts, :contract_end_date, :date
  end
end
