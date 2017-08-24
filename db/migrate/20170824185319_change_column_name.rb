class ChangeColumnName < ActiveRecord::Migration[5.0]
  def change
    rename_column :security_contracts, :organization_id, :building_id
  end
end
