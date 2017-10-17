class CreateCustomers < ActiveRecord::Migration[5.0]
  def change
    create_table :customers do |t|
      t.integer :qbo_id
      t.string :display_name

      t.timestamps
    end
  end
end
