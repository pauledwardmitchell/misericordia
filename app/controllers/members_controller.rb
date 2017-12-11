class MembersController < ApplicationController

  def show
    @member = Member.find(params[:id])

    url = URI("https://api.prosperworks.com/developer_api/v1/companies/" + @member.pw_id.to_s)
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl= true
    request = set_up_pw_get_request(url)
    response = http.request(request)
    response_as_json = JSON.parse(response.body)
    @member_data = {name: response_as_json["name"]
                   }
    @current_contract_data = []
    #add all contracts into an array
    all_org_contracts(@member.pw_id).select{ |c| c.current? }.each do |contract|
      contract_data = {id: contract.id,
                       name: contract.name,
                       monthly_payment: contract.cpa_monthly_payment,
                       monthly_savings: contract.monthly_savings,
                       monthly_rebate: contract.monthly_rebate,
                       end_date: contract.contract_end_date,
                       contract_type: contract.class.to_s
                       }
    #create object from array w class as a string
      @current_contract_data << contract_data
    end

  end

  private

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

end
