class AddRefreshTokenToQbo < ActiveRecord::Migration[5.0]
  def change
    add_column :qbos, :refresh_token, :string
  end
end
