module ReportCalcMonthly

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

    ann_revenue = ((report_end_date - report_start_date + 1)/365).to_f*(self.cpa_monthly_payment*12)*self.rebate_percentage
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

    contract_days = (report_end_date - report_start_date + 1)
    ann_revenue = (contract_days/365).to_f*((self.old_monthly_payment-self.cpa_monthly_payment)*12)
    ann_revenue
  end

  def monthly_savings
    self.old_monthly_payment - self.cpa_monthly_payment
  end

  def monthly_rebate
    self.cpa_monthly_payment*self.rebate_percentage
  end

end
