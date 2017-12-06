class AddTotalRevenueToCopierContract < ActiveRecord::Migration[5.0]
  def change
    add_column :copier_contracts, :total_rebate_to_cpa, :float
    add_column :solar_contracts, :total_rebate_to_cpa, :float
  end
end
