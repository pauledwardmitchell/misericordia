class DateTimeToDateLand < ActiveRecord::Migration[5.0]
  def change
    change_column :landscaping_contracts, :contract_start_date, :date
    change_column :landscaping_contracts, :contract_end_date, :date
  end
end
