class CreateWasteContracts < ActiveRecord::Migration[5.0]
  def change
    create_table :waste_contracts do |t|
      t.string :name
      t.integer :pw_organization_id
      t.integer :building_id
      t.integer :old_monthly_payment
      t.integer :cpa_monthly_payment
      t.datetime :contract_start_date
      t.datetime :contract_end_date
      t.integer :qbo_customer_id
      t.float :rebate_percentage
      t.boolean :cover_sheet_entered, default: false
      t.boolean :invoices_generated, default: false
      t.boolean :active, default: true

      t.timestamps
    end
  end
end
