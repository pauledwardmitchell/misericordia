class CreateSecurityContracts < ActiveRecord::Migration[5.0]
  def change
    create_table :security_contracts do |t|
      t.integer :og_id
      t.integer :security_vendor_id
      t.integer :organization_id
      t.integer :current_month_pay
      t.integer :new_month_pay
      t.string :new_start_date
      t.string :new_end_date
      t.string :notes

      t.timestamps
    end
  end
end
