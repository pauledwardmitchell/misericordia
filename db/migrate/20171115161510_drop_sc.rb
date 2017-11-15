class DropSc < ActiveRecord::Migration[5.0]
  def change
    drop_table :security_contracts
  end
end
