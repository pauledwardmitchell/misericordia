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
        new_contract = LandscapingContract.create(pw_organization_id: response_as_json_from_legal_name["id"],
                                                  name: "Landscaping at " + org.legal_name,
                                                  building_id: contract["Building_id"],
                                                  old_annual_payment: contract["PreviousPrice"],
                                                  cpa_annual_payment: contract["NewPrice"],
                                                  contract_start_date: contract["DateStarted"],
                                                  contract_end_date: contract["EndDate"],
                                                  qbo_customer_id: qbo_customer_id_from_vendor_name_string(contract["Vendor"]),
                                                  rebate_percentage: contract["Rebate"],
                                                  cover_sheet_entered: true)

    elsif response_from_common_name
      response_as_json_from_common_name = JSON.parse(response_from_common_name.body)[0]

        new_contract = LandscapingContract.create(pw_organization_id: response_as_json_from_common_name["id"],
                                                  name: "Landscaping at " + org.legal_name,
                                                  building_id: contract["Building_id"],
                                                  old_annual_payment: contract["PreviousPrice"],
                                                  cpa_annual_payment: contract["NewPrice"],
                                                  contract_start_date: contract["DateStarted"],
                                                  contract_end_date: contract["EndDate"],
                                                  qbo_customer_id: qbo_customer_id_from_vendor_name_string(contract["Vendor"]),
                                                  rebate_percentage: contract["Rebate"],
                                                  cover_sheet_entered: true)

      puts "Create Common!"
    else
     puts "NO DICE " + org.legal_name
    end

  end

end

task :load_waste => :environment do

  waste_contracts = File.read('db/data/Waste_ready.json')
  puts "File read"

  contracts_hash = JSON.parse(waste_contracts)
  puts "Hash made"

  puts contracts_hash.count

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
        new_contract = WasteContract.create(pw_organization_id: response_as_json_from_legal_name["id"],
                                            name: "Waste Hauling at " + org.legal_name,
                                            building_id: contract["Building_id"],
                                            old_monthly_payment: contract["CurrentMonthPay"],
                                            cpa_monthly_payment: contract["NewMonthPay"],
                                            contract_start_date: contract["NewStartDate"],
                                            contract_end_date: contract["NewEndDate"],
                                            qbo_customer_id: qbo_customer_id_from_vendor_name_string(contract["WasteVendor"]),
                                            rebate_percentage: contract["Rebate"],
                                            cover_sheet_entered: true)

    elsif response_from_common_name
      response_as_json_from_common_name = JSON.parse(response_from_common_name.body)[0]

        new_contract = WasteContract.create(pw_organization_id: response_as_json_from_common_name["id"],
                                            name: "Waste Hauling at " + org.legal_name,
                                            building_id: contract["Building_id"],
                                            old_monthly_payment: contract["CurrentMonthPay"],
                                            cpa_monthly_payment: contract["NewMonthPay"],
                                            contract_start_date: contract["NewStartDate"],
                                            contract_end_date: contract["NewEndDate"],
                                            qbo_customer_id: qbo_customer_id_from_vendor_name_string(contract["WasteVendor"]),
                                            rebate_percentage: contract["Rebate"],
                                            cover_sheet_entered: true)

        puts "Create Common!"
    else
     puts "NO DICE " + org.legal_name
    end

  end

end


task :load_clean => :environment do

  cleaning_contracts = File.read('db/data/Cleaning_ready.json')
  puts "File read"

  contracts_hash = JSON.parse(cleaning_contracts)
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
        new_contract = CleaningContract.create(pw_organization_id: response_as_json_from_legal_name["id"],
                                               name: "Cleaning at " + org.legal_name,
                                               building_id: contract["Building_id"],
                                               old_monthly_payment: contract["CurrentMonthPay"],
                                               cpa_monthly_payment: contract["NewMonthPay"],
                                               contract_start_date: contract["NewStartDate"],
                                               contract_end_date: "2021-12-31",
                                               qbo_customer_id: qbo_customer_id_from_vendor_name_string(contract["CleanVendor"]),
                                               rebate_percentage: contract["Rebate"],
                                               cover_sheet_entered: true)

    elsif response_from_common_name
      response_as_json_from_common_name = JSON.parse(response_from_common_name.body)[0]

        new_contract = CleaningContract.create(pw_organization_id: response_as_json_from_common_name["id"],
                                               name: "Cleaning at " + org.legal_name,
                                               building_id: contract["Building_id"],
                                               old_monthly_payment: contract["CurrentMonthPay"],
                                               cpa_monthly_payment: contract["NewMonthPay"],
                                               contract_start_date: contract["NewStartDate"],
                                               contract_end_date: "2021-12-31",
                                               qbo_customer_id: qbo_customer_id_from_vendor_name_string(contract["CleanVendor"]),
                                               rebate_percentage: contract["Rebate"],
                                               cover_sheet_entered: true)

      puts "Create Common!"
    else
     puts "NO DICE " + org.legal_name
    end

  end

end

task :load_security => :environment do

  security_contracts = File.read('db/data/Security_ready.json')
  puts "File read"

  contracts_hash = JSON.parse(security_contracts)
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
        new_contract = SecurityContract.create(pw_organization_id: response_as_json_from_legal_name["id"],
                                               name: "Security at " + org.legal_name,
                                               building_id: contract["Building_id"],
                                               old_monthly_payment: contract["CurrentMonthPay"],
                                               cpa_monthly_payment: contract["NewMonthPay"],
                                               contract_start_date: contract["NewStartDate"],
                                               contract_end_date: contract["NewEndDate"],
                                               qbo_customer_id: qbo_customer_id_from_og_security_vendor_id(contract["SecurityVendor_id"]),
                                               rebate_percentage: 0.05,
                                               cover_sheet_entered: true)

    elsif response_from_common_name
      response_as_json_from_common_name = JSON.parse(response_from_common_name.body)[0]

      puts "Create Common!"
        new_contract = SecurityContract.create(pw_organization_id: response_as_json_from_common_name["id"],
                                               name: "Security at " + org.legal_name,
                                               building_id: contract["Building_id"],
                                               old_monthly_payment: contract["CurrentMonthPay"],
                                               cpa_monthly_payment: contract["NewMonthPay"],
                                               contract_start_date: contract["NewStartDate"],
                                               contract_end_date: contract["NewEndDate"],
                                               qbo_customer_id: qbo_customer_id_from_og_security_vendor_id(contract["SecurityVendor_id"]),
                                               rebate_percentage: 0.05,
                                               cover_sheet_entered: true)

    else
     puts "NO DICE " + org.legal_name
    end

  end

end


task :load_electricity => :environment do

  electricity_rounds = File.read('db/data/Electricity_ready.json')
  rounds_hash = JSON.parse(electricity_rounds)

  join_data = File.read('db/data/Building_ElecRound_ready.json')
  join_hash = JSON.parse(join_data)

  join_hash.each do |contract|

    round = rounds_hash.select {|r| r["id"] == contract["ElecRound_id"]}
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
        new_contract = ElectricityContract.create(pw_organization_id: response_as_json_from_legal_name["id"],
                                                  name: "Electricity at " + org.legal_name + " - Round: " + round["Name"],
                                                  building_id: contract["Building_id"],
                                                  price_to_compare: round["SOSPrice"],
                                                  cpa_negotiated_price: round["RoundPrice"],
                                                  contract_start_date: contract["StartDate"],
                                                  contract_end_date: contract["EndDate"],
                                                  rebate_to_cpa: round["CPARebate"],
                                                  rebate_to_broker: round["BrokerRebate"],
                                                  estimated_savings: round["EstSavings"],
                                                  qbo_customer_id: qbo_customer_id_from_og_elec_broker_id(round["ElecBroker_id"]),
                                                  ldc_id: round["LDC_id"],
                                                  total_kwh_expected: round["TotalKwHExpected"],
                                                  cover_sheet_entered: true)

    elsif response_from_common_name
      response_as_json_from_common_name = JSON.parse(response_from_common_name.body)[0]

      puts "Create Common!"
        # new_contract = ElectricityContract.create(pw_organization_id: response_as_json_from_common_name["id"],
        #                                        name: "Electricity at " + org.legal_name,
        #                                        building_id: contract["Building_id"],
        #                                        old_monthly_payment: contract["CurrentMonthPay"],
        #                                        cpa_monthly_payment: contract["NewMonthPay"],
        #                                        contract_start_date: contract["NewStartDate"],
        #                                        contract_end_date: contract["NewEndDate"],
        #                                        qbo_customer_id: qbo_customer_id_from_og_security_vendor_id(contract["SecurityVendor_id"]),
        #                                        rebate_percentage: 0.05,
        #                                        cover_sheet_entered: true)

    else
     puts "NO DICE " + org.legal_name
    end

  end

end

###

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
    when "Smart Cleaning Solutions"
      return 99
    when"PMM"
      return 120
    when "CleanNet USA"
      return 108
    when "Service Industries LLC"
      return 104
    when "Fresco Cleaning"
      return 103
    when "Busy Bee"
      return 248
    when "GSI"
      return 176
    when "Tenleytown"
      return 3
    when "Bates"
      return 1
    when "Affordable Refuse"
      return 246
    end
  end

  def qbo_customer_id_from_og_security_vendor_id(og_vendor_id)
    case og_vendor_id
    when 1
      return 121
    when 2
      return 178
    when 3
      return 247
    when 4
      return 273
    end
  end

  def qbo_customer_id_from_og_elec_broker_id(og_broker_id)
    case og_broker_id
    when 2
      return
    when 3
      return
    when 4
      return 6 #cqi
    when 6
      return
    when 7
      return 9 #nextility
    when 8
      return 11 #nrg
    end
  end
