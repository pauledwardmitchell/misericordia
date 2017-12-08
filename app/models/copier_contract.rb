class CopierContract < ApplicationRecord
  has_many :copier_invoices

  def annualized_revenue(year)
    current_year_invoices = self.copier_invoices.select{ |i| i.current? }

    if current_year_invoices.count > 0
      total = current_year_invoices.map{ |i| i.amount }.reduce(:+)
      return total
    else
      return 0
    end
  end

end
