class CreateMembers < ActiveRecord::Migration[5.0]
  def change
    create_table :members do |t|
      t.integer :pw_id, uniqueness: true

      t.timestamps
    end
  end
end
