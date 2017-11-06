class CreateLandscapingContracts < ActiveRecord::Migration[5.0]
  def change
    create_table :landscaping_contracts do |t|
      t.integer :pw_organization_id
      t.integer :building_id
      t.integer :old_annual_payment
      t.integer :cpa_annual_payment
      t.datetime :contract_start_date
      t.datetime :contract_end_date
      t.integer :pw_vendor_id
      t.float :rebate_percentage
      t.datetime :billing_start_date
      t.datetime :billing_end_date
      t.boolean :cover_sheet_entered, default: false
      t.boolean :invoices_generated, default: false

      t.timestamps
    end
  end
end
