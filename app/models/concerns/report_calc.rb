module ReportCalc

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

    ann_revenue = ((report_end_date - report_start_date + 1)/365).to_i*self.cpa_annual_payment*self.rebate_percentage
    ann_revenue
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
