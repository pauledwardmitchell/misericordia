class CreateBuildings < ActiveRecord::Migration[5.0]
  def change
    create_table :buildings do |t|
      t.integer :og_id
      t.string :primary_building
      t.string :street_address
      t.string :city
      t.string :state
      t.integer :zip
      t.integer :square_footage
      t.integer :organization_id

      t.timestamps
    end
  end
end
