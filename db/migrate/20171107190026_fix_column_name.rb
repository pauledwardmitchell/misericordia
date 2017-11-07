class FixColumnName < ActiveRecord::Migration[5.0]
  def change
    rename_column :landscaping_contracts, :pw_vendor_id, :qbo_customer_id
  end
end
