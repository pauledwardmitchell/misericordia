class CreateCopierInvoices < ActiveRecord::Migration[5.0]
  def change
    create_table :copier_invoices do |t|
      t.integer :copier_contract_id
      t.date :date
      t.float :amount

      t.timestamps
    end
  end
end
