class CreateSolarInvoices < ActiveRecord::Migration[5.0]
  def change
    create_table :solar_invoices do |t|
      t.integer :solar_contract_id
      t.date :date
      t.float :amount

      t.timestamps
    end
  end
end
