class CreateSolarContracts < ActiveRecord::Migration[5.0]
  def change
    create_table :solar_contracts do |t|
      t.string :name
      t.integer :pw_organization_id
      t.integer :estimated_savings
      t.date :scorecard_start_date
      t.date :scorecard_end_date
      t.integer :qbo_customer_id
      t.boolean :cover_sheet_entered, default: false
      t.boolean :invoices_generated, default: false
      t.boolean :active, default: true

      t.timestamps
    end
  end
end
