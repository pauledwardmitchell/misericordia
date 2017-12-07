class Invoice < ApplicationRecord
  belongs_to :copier_contract
  belongs_to :solar_contract

  def current?
    if self.date.year == Date.today.year
      true
    else
      false
    end
  end

end
