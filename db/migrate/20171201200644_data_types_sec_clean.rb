class DataTypesSecClean < ActiveRecord::Migration[5.0]
  def change
    change_column :cleaning_contracts, :old_monthly_payment, :float
    change_column :cleaning_contracts, :cpa_monthly_payment, :float
    change_column :cleaning_contracts, :contract_start_date, :date
    change_column :cleaning_contracts, :contract_end_date, :date
    change_column :security_contracts, :old_monthly_payment, :float
    change_column :security_contracts, :cpa_monthly_payment, :float
    change_column :security_contracts, :contract_start_date, :date
    change_column :security_contracts, :contract_end_date, :date
  end
end
