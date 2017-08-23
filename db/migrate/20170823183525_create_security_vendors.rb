class CreateSecurityVendors < ActiveRecord::Migration[5.0]
  def change
    create_table :security_vendors do |t|
      t.string :name

      t.timestamps
    end
  end
end
