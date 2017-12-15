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

  def annualized_savings(year)
    if contract_ends_prior_to(year) || !contract_started_by_end_of(year)
      return 0
    end

    if contract_started_by_start_of(year)
      report_start_date = Date.new(year,1,1)
    else
      report_start_date = self.contract_start_date
    end

    if contract_ends_midyear(year)
      report_end_date = self.contract_end_date
    else
      report_end_date = Date.new(year,12,31)
    end

    ann_savings = ((report_end_date - report_start_date + 1)/365).to_f*contract_savings
    ann_savings
  end

  def contract_savings
    self.estimated_savings
  end

  def cpa_monthly_payment
    0
  end

  def rebate_percentage
    0
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

  def contract_start_date
    self.scorecard_start_date
  end

  private

  def contract_ends_midyear(year)
    if Date.new(year,12,31) > self.contract_end_date
      true
    else
      false
    end
  end

  def contract_ends_prior_to(year)
    if Date.new(year,1,1) > self.contract_end_date
      true
    else
      false
    end
  end

  def contract_started_by_end_of(year)
    if Date.new(year,12,31) < self.contract_start_date
      false
    else
      true
    end
  end

  def contract_started_by_start_of(year)
    if Date.new(year,1,1) >= self.contract_start_date
      true
    else
      false
    end
  end

end
