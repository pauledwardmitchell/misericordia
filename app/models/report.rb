class Report

  def annualized_savings_total(year)
    total_savings(year, all_contracts)
  end

  def annualized_savings_low_income(year)
    url = URI("https://api.prosperworks.com/developer_api/v1/companies/search")
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl= true

    request = set_up_pw_post_request(url)
    request.body = "{\n  \"page_size\":200, \n  \"tags\":\"low-income\"\n}"
    response = http.request(request)
    tracked_organizations = JSON.parse(response.body)
    tracked_organizations_savings = 0
    tracked_organizations.each do |org|
      org_total_savings = total_savings(year, all_org_contracts(org["id"]))
      if org_total_savings
        p org["name"]
        p org_total_savings
        tracked_organizations_savings = tracked_organizations_savings + org_total_savings
      end
    end
    tracked_organizations_savings
  end

  private
  def annualized_savings_subset(year, subset_array)
    total_savings(year, subset_array)
  end

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


  def set_up_pw_post_request(url)
    request = Net::HTTP::Post.new(url)
    request["x-pw-accesstoken"] = ENV['PROSPERWORKS_KEY']
    request["x-pw-application"] = 'developer_api'
    request["x-pw-useremail"] = 'felipe@cpa.coop'
    request["content-type"] = 'application/json'
    request
  end

end
