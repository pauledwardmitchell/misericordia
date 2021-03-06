class CreateMonthlyContracts < ActiveRecord::Migration[5.0]
  def change
    create_table :monthly_contracts do |t|
      t.string :name
      t.integer :pw_organization_id
      t.integer :building_id
      t.integer :old_monthly_payment
      t.integer :cpa_monthly_payment
      t.date :contract_start_date
      t.date :contract_end_date
      t.integer :qbo_customer_id
      t.float :rebate_percentage
      t.boolean :cover_sheet_entered
      t.boolean :invoices_generated
      t.boolean :active

      t.timestamps
    end
  end
end
