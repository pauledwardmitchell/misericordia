class SolarContract < ApplicationRecord
  has_many :solar_invoices

  def annualized_revenue(year)
    current_year_invoices = self.solar_invoices.select{ |i| i.current? }
    total = current_year_invoices.map{ |i| i.amount }.reduce(:+)
    total
  end

end
