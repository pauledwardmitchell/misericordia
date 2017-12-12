class ElectricityContract < ApplicationRecord
  include ReportCalc

  def current?
    year = Date.today.year
    if contract_ends_prior_to(year) || !contract_started_by_end_of(year)
      false
    else
      true
    end
  end

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

    ann_revenue = ((report_end_date - report_start_date + 1)/365).to_f*contract_revenue
    ann_revenue
  end

  def cpa_monthly_payment
    self.cpa_negotiated_price*self.total_kwh_expected/12
  end

  def monthly_savings
    (self.price_to_compare-self.cpa_negotiated_price)*self.total_kwh_expected/12
  end

  def monthly_rebate
    contract_revenue/12
  end

  def rebate_percentage
    self.rebate_to_cpa
  end

  private

  def contract_revenue
    self.total_kwh_expected*self.rebate_to_cpa
  end

end
