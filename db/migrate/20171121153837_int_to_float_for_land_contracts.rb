class IntToFloatForLandContracts < ActiveRecord::Migration[5.0]
  def change
    change_column :landscaping_contracts, :old_annual_payment, :float
    change_column :landscaping_contracts, :cpa_annual_payment, :float
  end
end
