class ChangeLdcTypeInGasContracts < ActiveRecord::Migration[5.0]
  def change
    change_column :gas_contracts, :ldc, 'integer USING CAST(ldc AS integer)'
  end
end
