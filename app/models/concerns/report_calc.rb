module ReportCalc

  def current?
    year = Date.today.year
    if contract_ends_prior_to(year) || !contract_started_by_end_of(year)
      false
    else
      true
    end
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
