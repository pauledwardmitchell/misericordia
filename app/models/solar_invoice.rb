class SolarInvoice < ApplicationRecord
  belongs_to :solar_contract

  def current?
    if self.date.year == Date.today.year
      true
    else
      false
    end
  end

end
