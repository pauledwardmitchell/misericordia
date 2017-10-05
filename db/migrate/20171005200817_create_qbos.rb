class CreateQbos < ActiveRecord::Migration[5.0]
  def change
    create_table :qbos do |t|
      t.string :access_token
      t.string :realm_id
      t.timestamps
    end
  end
end
