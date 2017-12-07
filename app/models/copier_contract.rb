class CopierContract < ApplicationRecord
  has_many :copier_invoices

  def annualized_revenue(year)
    current_year_invoices = self.copier_invoices.select{ |i| i.current? }
    total = current_year_invoices.map{ |i| i.amount }.reduce(:+)
    total
  end

end
