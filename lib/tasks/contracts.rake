desc "This task loads contracts from old db"

task :load_land => :environment do

  landscaping_contracts = File.read('db/data/Landscaping_ready.json')
  puts "File read"

  contracts_hash = JSON.parse(landscaping_contracts)
  puts "Hash made"


  contracts_hash.each do |contract|

    org = find_org_from_building_id(contract["Building_id"])
    puts org.legal_name

    url = URI("https://api.prosperworks.com/developer_api/v1/companies/search")

    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl= true

    request = set_up_pw_post_request(url)

    #Request with Legal Name
    request.body = "{\n  \"name\":\"" + org.legal_name + "\"\n}"
    response_from_legal_name = http.request(request)
    puts "Response from legal name: " + org.legal_name
    puts response_from_legal_name.read_body

    #Request with Common Name
    if org.common_name.length > 1
      request.body = "{\n  \"name\":\"" + org.common_name + "\"\n}"
      response_from_common_name = http.request(request)
      puts "Response from common name: " + org.common_name
      puts response_from_common_name.read_body
    else
      puts "No common name"
    end

    if response_as_json_from_legal_name = JSON.parse(response_from_legal_name.body)[0]

      puts "Create Legal!"
        # new_contract = LandscapingContract.create(pw_organization_id: response_as_json_from_legal_name["id"],
        #                                           building_id: contract["Building_id"],
        #                                           old_annual_payment: contract["PreviousPrice"],
        #                                           cpa_annual_payment: contract["NewPrice"],
        #                                           contract_start_date: contract["DateStarted"],
        #                                           contract_end_date: contract["EndDate"],
        #                                           qbo_customer_id: qbo_customer_id_from_vendor_name(contract["Vendor"]),
        #                                           rebate_percentage: contract["Rebate"],
        #                                           cover_sheet_entered: true)
        #
    elsif response_from_common_name
      response_as_json_from_common_name = JSON.parse(response_from_common_name.body)[0]

        # new_contract = LandscapingContract.create(pw_organization_id: response_as_json_from_common_name["id"],
        #                                           building_id: contract["Building_id"],
        #                                           old_annual_payment: contract["PreviousPrice"],
        #                                           cpa_annual_payment: contract["NewPrice"],
        #                                           contract_start_date: contract["DateStarted"],
        #                                           contract_end_date: contract["EndDate"],
        #                                           qbo_customer_id: qbo_customer_id_from_vendor_name(contract["Vendor"]),
        #                                           rebate_percentage: contract["Rebate"],
        #                                           cover_sheet_entered: true)

      puts "Create Common!"
    else
     puts "NO DICE " + org.legal_name
    end

  end



end

  def find_org_from_building_id(building_id)
    building = Building.find(building_id)
    organization = building.organization
    organization
  end

  def set_up_pw_post_request(url)
    request = Net::HTTP::Post.new(url)
    request["x-pw-accesstoken"] = ENV['PROSPERWORKS_KEY']
    request["x-pw-application"] = 'developer_api'
    request["x-pw-useremail"] = 'felipe@cpa.coop'
    request["content-type"] = 'application/json'
    request
  end

  def qbo_customer_id_from_vendor_name_string(name)
    case name
    when "Complete"
      return 95
    when "Greenscape"
      return 174
    when "Level Green"
      return 10
    when "Solar Gardens"
      return 126
    end
  end
