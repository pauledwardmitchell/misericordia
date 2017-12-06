class SolarContract < ApplicationRecord

  def annualized_revenue(year)

    if year == self.scorecard_start_date.year
      return self.total_rebate_to_cpa
    else
      return 0
    end

  end

end
