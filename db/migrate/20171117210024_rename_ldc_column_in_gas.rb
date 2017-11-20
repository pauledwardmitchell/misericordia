class RenameLdcColumnInGas < ActiveRecord::Migration[5.0]
  def change
    rename_column :gas_contracts, :ldc, :ldc_id
  end
end
