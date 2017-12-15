class Member < ApplicationRecord
  validates :pw_id, uniqueness: true

  def pw_company
    pw_api = PwApi.new
    url = URI("https://api.prosperworks.com/developer_api/v1/companies/" + self.pw_id.to_s)
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl= true
    company_request = pw_api.get_request(url)
    company_response = http.request(company_request)
    company_response_as_json = JSON.parse(company_response.body)
    company_response_as_json
  end

  def pw_unwon_opportunities
    pw_api = PwApi.new
    all_opportunities = pw_api.all_opportunities
    all_unwon_member_opportunities = all_opportunities.select{ |o| o["company_id"] == self.pw_id && o["status"] != "Won" }
    all_unwon_member_opportunities
  end

  def all_contracts
    landscaping_contracts = LandscapingContract.where(pw_organization_id: self.pw_id)
    waste_contracts = WasteContract.where(pw_organization_id: self.pw_id)
    cleaning_contracts = CleaningContract.where(pw_organization_id: self.pw_id)
    security_contracts = SecurityContract.where(pw_organization_id: self.pw_id)
    electricity_contracts = ElectricityContract.where(pw_organization_id: self.pw_id)
    gas_contracts = GasContract.where(pw_organization_id: self.pw_id)
    copier_contracts = CopierContract.where(pw_organization_id: self.pw_id)
    solar_contracts = SolarContract.where(pw_organization_id: self.pw_id)
    monthly_contracts = MonthlyContract.where(pw_organization_id: self.pw_id)
    contracts_array = landscaping_contracts + waste_contracts + cleaning_contracts + security_contracts + electricity_contracts + gas_contracts + copier_contracts + solar_contracts + monthly_contracts
    contracts_array
  end

  def all_current_contracts
    self.all_contracts.select{ |c| c.current? }
  end

  def pvr(all_current_contracts, tags_array)
    (pvr_numerator(all_current_contracts) / pvr_demoninator(tags_array).to_f).round(2)
  end

  def sell_list(all_contracts, tags_array)
    start_list = ["Cleaning", "Copier", "Electricity", "Gas", "Landscaping", "Security", "Solar", "Waste"]
    class_list = contract_classes(all_contracts)
    current_contract_areas = class_list.map{ |c| c.chomp('Contract') }
    sell_list = start_list - current_contract_areas
    sell_list = sell_list - ineligible_list(tags_array)
    sell_list
  end

  def institution_type(array)
    if array.include?("synagogue")
      return "Synagogue"
    end
    if array.include?("charter school")
      return "Charter School"
    end
    if array.include?("church")
      return "Church"
    end
    if array.include?("non-profit")
      return "Non-profit"
    end
    if array.include?("multi-family housing")
      return "Multi-Family Housing"
    end
    if array.include?("religious congregation")
      return "Religious Congregation"
    end
    if array.include?("college")
      return "College"
    end
    if array.include?("retirement")
      return "Retirement Home"
    end
    if array.include?("charter school")
      return "Charter School"
    end
    if array.include?("independent school")
      return "Independent School"
    end
    if array.include?("institution-other")
      return "Institution Type: Other"
    end
  end

  private

  def pvr_numerator(all_current_contracts)
    contract_classes(all_current_contracts).count
  end

  def pvr_demoninator(tags_array)
    exceptions_array = tags_array.select { |str| str.start_with?("no-") }
    num_exceptions = exceptions_array.count
    denominator = (8 - num_exceptions)
    denominator
  end

  def contract_classes(all_contracts)
    contract_types = all_contracts.map {|c| c.class.to_s}
    contract_types = contract_types.uniq
    contract_types
  end

  def ineligible_list(tags_array)
    ineligible_list = []

    if tags_array.include?('no-cleaning')
      ineligible_list << "Cleaning"
    end
    if tags_array.include?('no-copier')
      ineligible_list << "Copier"
    end
    if tags_array.include?('no-electrivity')
      ineligible_list << "Electrivity"
    end
    if tags_array.include?('no-gas')
      ineligible_list << "Gas"
    end
    if tags_array.include?('no-landscaping')
      ineligible_list << "Landscaping"
    end
    if tags_array.include?('no-security')
      ineligible_list << "Security"
    end
    if tags_array.include?('no-solar')
      ineligible_list << "Solar"
    end
    if tags_array.include?('no-waste')
      ineligible_list << "Waste"
    end
    ineligible_list
  end

end
