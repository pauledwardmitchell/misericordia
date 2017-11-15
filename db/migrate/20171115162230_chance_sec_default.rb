class ChanceSecDefault < ActiveRecord::Migration[5.0]
  def change
    change_column_default :security_contracts, :cover_sheet_entered, false
    change_column_default :security_contracts, :invoices_generated, false
    change_column_default :security_contracts, :active, true
  end
end
