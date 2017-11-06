class AddNameToLandscapingContract < ActiveRecord::Migration[5.0]
  def change
    add_column :landscaping_contracts, :name, :string
    add_column :landscaping_contracts, :active, :boolean, default: true
  end
end
