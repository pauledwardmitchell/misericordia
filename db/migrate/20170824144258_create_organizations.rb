class CreateOrganizations < ActiveRecord::Migration[5.0]
  def change
    create_table :organizations do |t|
      t.integer :og_id
      t.string :legal_name
      t.string :common_name

      t.timestamps
    end
  end
end
