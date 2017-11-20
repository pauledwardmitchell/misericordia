class CreateElectricityContracts < ActiveRecord::Migration[5.0]
  def change
    create_table :electricity_contracts do |t|
      t.string :name
      t.integer :pw_organization_id
      t.integer :building_id
      t.integer :annual_kwh
      t.float :price_to_compare
      t.float :cpa_negotiated_price
      t.date :contract_start_date
      t.date :contract_end_date
      t.integer :qbo_customer_id
      t.float :rebate_to_cpa
      t.float :rebate_to_broker
      t.float :estimated_savings
      t.integer :ldc_id
      t.integer :total_kwh_expected
      t.boolean :cover_sheet_entered, default: false
      t.boolean :invoices_generated, default: false
      t.boolean :active, default: true

      t.timestamps
    end
  end
end
