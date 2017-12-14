class MembersController < ApplicationController

  def show
    @member = Member.find(params[:id])

    url = URI("https://api.prosperworks.com/developer_api/v1/companies/" + @member.pw_id.to_s)
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl= true
    company_request = set_up_pw_get_request(url)
    company_response = http.request(company_request)
    company_response_as_json = JSON.parse(company_response.body)
    tags = company_response_as_json["tags"]
    @current_contract_data = []
    #add all contracts into an array
    all_contracts = all_org_contracts(@member.pw_id)
    all_active_contracts = all_contracts.select{ |c| c.current? }
    # all_active_contracts_no_duplicate_buildings = remove_duplicate_buildings(all_active_contracts)
    all_active_contracts.each do |contract|
      contract_data = {id: contract.id,
                       name: contract.name,
                       monthly_payment: contract.cpa_monthly_payment,
                       monthly_savings: contract.monthly_savings,
                       monthly_rebate: contract.monthly_rebate,
                       rebate_percentage: contract.rebate_percentage,
                       end_date: contract.contract_end_date,
                       contract_type: contract.class.to_s
                       }
    #create object from array w class as a string
      @current_contract_data << contract_data
    end

    url = URI("https://api.prosperworks.com/developer_api/v1/opportunities/search")
    opportunities_request = set_up_pw_post_request(url)
    opportunities_request.body = "{\n  \"page_size\": 200,\n \"page_number\": 1,\n  \"sort_by\": \"name\"\n  \n}"
    opportunities_response_pg_1 = http.request(opportunities_request)
    opportunities_response_as_json_pg_1 = JSON.parse(opportunities_response_pg_1.body)

    opportunities_request.body = "{\n  \"page_size\": 200,\n \"page_number\": 2,\n  \"sort_by\": \"name\"\n  \n}"
    opportunities_response_pg_2 = http.request(opportunities_request)
    opportunities_response_as_json_pg_2 = JSON.parse(opportunities_response_pg_2.body)

    opportunities_request.body = "{\n  \"page_size\": 200,\n \"page_number\": 3,\n  \"sort_by\": \"name\"\n  \n}"
    opportunities_response_pg_3 = http.request(opportunities_request)
    opportunities_response_as_json_pg_3 = JSON.parse(opportunities_response_pg_3.body)

    opportunities_request.body = "{\n  \"page_size\": 200,\n \"page_number\": 4,\n  \"sort_by\": \"name\"\n  \n}"
    opportunities_response_pg_4 = http.request(opportunities_request)
    opportunities_response_as_json_pg_4 = JSON.parse(opportunities_response_pg_4.body)

    all_opportunities = opportunities_response_as_json_pg_1 + opportunities_response_as_json_pg_2 + opportunities_response_as_json_pg_3 + opportunities_response_as_json_pg_4
    all_member_opportunities = all_opportunities.select{ |o| o["company_id"] == @member.pw_id && o["status"] != "Won" }

    numerator = pvr_numerator(all_active_contracts)
    denominator = pvr_demoninator(tags)
    @member_data = {name: company_response_as_json["name"],
                    institution_type: institution_type(tags),
                    sell_list: sell_list(all_active_contracts, tags),
                    pvr: (numerator/denominator.to_f.round(2)),
                    city_state: city_state_from_pw_company(company_response_as_json),
                    opportunities: all_member_opportunities
                   }
    @totals_data = {monthly_payment_total: all_active_contracts.map{|c| c.cpa_monthly_payment }.reduce(:+),
                    monthly_savings_total: all_active_contracts.map{|c| c.monthly_savings }.reduce(:+),
                    monthly_rebate_total: all_active_contracts.map{|c| c.monthly_rebate }.reduce(:+)
                   }

  end

  private

  # def remove_duplicate_buildings(all_active_contracts)
  #   final_array =[]

  #   all_active_contracts.each do |c|
  #     #pop c out of all_active_contracts (dont want to compare it to itself)
  #     loop_array = all_active_contracts
  #     loop_array.delete(c)
  #     #if c has same class and same building_id as another contract
  #     prior_contract = loop_array.select{ |contract| contract.class == c.class && contract.building_id == c.building_id}

  #     if prior_contract[0] != nil
  #       if prior_contract[0].contract_start_date > c.contract_start_date
  #         final_array << prior_contract[0]
  #       else
  #         final_array << c
  #       end
  #     else
  #       final_array << c
  #     end

  #   end
  #   final_array = final_array.uniq
  #   final_array
  # end

  def set_up_pw_post_request(url)
    request = Net::HTTP::Post.new(url)
    request["x-pw-accesstoken"] = ENV['PROSPERWORKS_KEY']
    request["x-pw-application"] = 'developer_api'
    request["x-pw-useremail"] = 'felipe@cpa.coop'
    request["content-type"] = 'application/json'
    request
  end

  def set_up_pw_get_request(url)
    request = Net::HTTP::Get.new(url)
    request["x-pw-accesstoken"] = ENV['PROSPERWORKS_KEY']
    request["x-pw-application"] = 'developer_api'
    request["x-pw-useremail"] = 'felipe@cpa.coop'
    request["content-type"] = 'application/json'
    request
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

  def pvr_numerator(all_contracts)
    contract_classes(all_contracts).count
  end

  def contract_classes(all_contracts)
    contract_types = all_contracts.map {|c| c.class.to_s}
    contract_types = contract_types.uniq
    contract_types
  end

  def pvr_demoninator(tags_array)
    exceptions_array = tags_array.select { |str| str.start_with?("no-") }
    num_exceptions = exceptions_array.count
    denominator = (8 - num_exceptions)
  end

  def pvr
    pvr_numerator / pvr_demoninator.to_f
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
      return "Retirement Hoem"
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

  def sell_list(all_contracts, tags_array)
    start_list = ["Cleaning", "Copier", "Electricity", "Gas", "Landscaping", "Security", "Solar", "Waste"]
    class_list = contract_classes(all_contracts)
    current_contract_areas = class_list.map{ |c| c.chomp('Contract') }
    sell_list = start_list - current_contract_areas
    sell_list = sell_list - ineligible_list(tags_array)
    sell_list
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

  def city_state_from_pw_company(company)
    if company["address"]["city"] && company["address"]["state"]
      city_state = company["address"]["city"] + ", " + company["address"]["state"]
      city_state
    end
  end

end
