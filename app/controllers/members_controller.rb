class MembersController < ApplicationController

  def show
    @member = Member.find(params[:id])

    url = URI("https://api.prosperworks.com/developer_api/v1/companies/" + @member.pw_id.to_s)
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl= true
    request = set_up_pw_get_request(url)
    response = http.request(request)
    response_as_json = JSON.parse(response.body)
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
    numerator = pvr_numerator(all_active_contracts)
    denominator = pvr_demoninator(response_as_json["tags"])
    @member_data = {name: response_as_json["name"],
                    tags: response_as_json["tags"],
                    pvr: (numerator/denominator.to_f)
                   }
    @totals_data = {monthly_payment_total: all_active_contracts.map{|c| c.cpa_monthly_payment }.reduce(:+),
                    monthly_savings_total: all_active_contracts.map{|c| c.monthly_savings }.reduce(:+),
                    monthly_rebate_total: all_active_contracts.map{|c| c.monthly_rebate }.reduce(:+)
                   }

  end

  private

  def remove_duplicate_buildings(all_active_contracts)
    final_array =[]

    all_active_contracts.each do |c|
      #pop c out of all_active_contracts (dont want to compare it to itself)
      loop_array = all_active_contracts
      loop_array.delete(c)
      #if c has same class and same building_id as another contract
      prior_contract = loop_array.select{ |contract| contract.class == c.class && contract.building_id == c.building_id}

      if prior_contract[0] != nil
        if prior_contract[0].contract_start_date > c.contract_start_date
          final_array << prior_contract[0]
        else
          final_array << c
        end
      else
        final_array << c
      end

    end
    final_array = final_array.uniq
    final_array
  end

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
    contract_types = all_contracts.map {|c| c.class}
    contract_types = contract_types.uniq
    contract_types.count
  end

  def pvr_demoninator(tags_array)
    exceptions_array = tags_array.select { |str| str.start_with?("no-") }
    num_exceptions = exceptions_array.count
    denominator = (8 - num_exceptions)
  end

  def pvr
    pvr_numerator / pvr_demoninator
  end

end
