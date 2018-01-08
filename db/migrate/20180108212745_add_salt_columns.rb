class AddSaltColumns < ActiveRecord::Migration[5.0]
  def change
    add_column :qbos, :encrypted_access_token_iv, :string
    add_column :qbos, :encrypted_refresh_token_iv, :string
    add_column :qbos, :encrypted_realm_id_iv, :string
  end
end
