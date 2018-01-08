class AddEncrColumnsToQbo < ActiveRecord::Migration[5.0]
  def change
    add_column :qbos, :encrypted_access_token, :string
    add_column :qbos, :encrypted_refresh_token, :string
    add_column :qbos, :encrypted_realm_id, :string
  end
end
