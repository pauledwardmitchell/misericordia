class LandscapingContract < ApplicationRecord
  include ReportCalc

  def annualized_revenue(year)
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

    ann_revenue = ((report_end_date - report_start_date + 1)/365).to_f*self.cpa_annual_payment*self.rebate_percentage
    ann_revenue
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

    ann_savings = ((report_end_date - report_start_date + 1)/365).to_f*(self.old_annual_payment-self.cpa_annual_payment)
    ann_savings
  end

  def cpa_monthly_payment
    self.cpa_annual_payment/12
  end

  def monthly_savings
    (self.old_annual_payment-self.cpa_annual_payment)/12
  end

  def monthly_rebate
    (self.cpa_annual_payment*self.rebate_percentage)/12
  end

end
