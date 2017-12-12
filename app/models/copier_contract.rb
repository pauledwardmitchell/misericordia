class CopierContract < ApplicationRecord
  has_many :copier_invoices

  def current?
    year = Date.today.year
    if self.scorecard_start_date.year <= year + 5
      true
    else
      false
    end
  end

  def annualized_revenue(year)
    current_year_invoices = self.copier_invoices.select{ |i| i.current? }

    if current_year_invoices.count > 0
      total = current_year_invoices.map{ |i| i.amount }.reduce(:+)
      return total
    else
      return 0
    end
  end

  def cpa_monthly_payment
    "n/a"
  end

  def monthly_savings
    self.estimated_savings/12
  end

  def monthly_rebate
    self.copier_invoices.map{ |i| i.amount }.reduce(:+)/12
  end

  def contract_end_date
    self.scorecard_end_date
  end

end
