class AddAnnualElecUsageColumnToBuildings < ActiveRecord::Migration[5.0]
  def change
    add_column :buildings, :annual_elec_usage, :integer
    add_column :buildings, :annual_gas_usage, :integer
  end
end
