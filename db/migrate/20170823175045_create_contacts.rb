class CreateContacts < ActiveRecord::Migration[5.0]
  def change
    create_table :contacts do |t|
      t.integer :og_id
      t.string :salutation
      t.string :first_name
      t.string :last_name
      t.string :level
      t.string :email
      t.string :frequency
      t.string :cell_phone
      t.string :office_phone
      t.string :fax
      t.string :date_of_contact
      t.string :cpa_contact

      t.timestamps
    end
  end
end
