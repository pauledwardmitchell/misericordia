class Report

  def annualized_savings_total(year)
    total_savings(year, all_contracts)
  end


  private

  def total_savings(year, array)
    array.map{ |c| c.annualized_savings(year) }.reduce(:+)
  end

  def all_contracts
    landscaping_contracts = LandscapingContract.all
    waste_contracts = WasteContract.all
    cleaning_contracts = CleaningContract.all
    security_contracts = SecurityContract.all
    electricity_contracts = ElectricityContract.all
    gas_contracts = GasContract.all
    copier_contracts = CopierContract.all
    solar_contracts = SolarContract.all
    monthly_contracts = MonthlyContract.all
    contracts_array = landscaping_contracts + waste_contracts + cleaning_contracts + security_contracts + electricity_contracts + gas_contracts + copier_contracts + solar_contracts + monthly_contracts
    contracts_array
  end

  def all_org_contracts(id)
    landscaping_contracts = LandscapingContract.where(pw_organization_id: id)
    waste_contracts = WasteContract.where(pw_organization_id: id)
    cleaning_contracts = CleaningContract.where(pw_organization_id: id)
    security_contracts = SecurityContract.where(pw_organization_id: id)
    electricity_contracts = ElectricityContract.where(pw_organization_id: id)
    gas_contracts = GasContract.where(pw_organization_id: id)
    copier_contracts = CopierContract.where(pw_organization_id: id)
    solar_contracts = SolarContract.where(pw_organization_id: id)
    monthly_contracts = MonthlyContract.where(pw_organization_id: id)
    contracts_array = landscaping_contracts + waste_contracts + cleaning_contracts + security_contracts + electricity_contracts + gas_contracts + copier_contracts + solar_contracts + monthly_contracts
    contracts_array
  end

end
