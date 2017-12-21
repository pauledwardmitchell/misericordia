class ChartsController < ApplicationController

  def service_area_year_end
    @chart_data = {
      "Electricity": total_revenue(2017, ElectricityContract.all),
      "Cleaning": total_revenue(2017, CleaningContract.all),
      "Security": total_revenue(2017, SecurityContract.all),
      "Gas": total_revenue(2017, GasContract.all),
      "Waste": total_revenue(2017, WasteContract.all),
      "Landscaping": total_revenue(2017, LandscapingContract.all),
      "Copier": total_copier_revenue(2017, CopierContract.all),
      "Solar": total_solar_revenue(2017, SolarContract.all),
      "Other": total_revenue(2017, MonthlyContract.all)
    }

    render json: @chart_data
  end

  private

  def total_revenue(year, array)
    array.map{ |c| c.annualized_revenue(year) }.reduce(:+)
  end

  def total_copier_revenue(year, array)
    all_invoices = []
    array.each do |contract|
      all_invoices = all_invoices + contract.copier_invoices
      all_invoices
    end
    current_invoices = all_invoices.select{ |i| i.current? }
    total = current_invoices.map{ |i| i.amount }.reduce(:+)
    total
  end

  def total_solar_revenue(year, array)
    all_invoices = []
    array.each do |contract|
      all_invoices = all_invoices + contract.solar_invoices
      all_invoices
    end
    current_invoices = all_invoices.select{ |i| i.current? }
    total = current_invoices.map{ |i| i.amount }.reduce(:+)
    total
  end

end
