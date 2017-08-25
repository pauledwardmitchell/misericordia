class CreateRoles < ActiveRecord::Migration[5.0]
  def change
    create_table :roles do |t|
      t.integer :og_id
      t.integer :organization_id
      t.integer :contact_id
      t.string :type
      t.string :role
      t.string :committee_name
      t.string :date_noted
      t.string :date_term_ends

      t.timestamps
    end
  end
end
