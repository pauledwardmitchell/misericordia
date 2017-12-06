class AddBuildingIdToGasContracts < ActiveRecord::Migration[5.0]
  def change
    add_column :gas_contracts, :building_id, :integer
  end
end
