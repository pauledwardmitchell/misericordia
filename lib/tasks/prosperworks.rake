desc "This task updates people in PW"

task :update_orgs => :environment do

  orgs = Organization.take(2)

  orgs.each do |org|

    url = URI("https://api.prosperworks.com/developer_api/v1/companies/search")

    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl= true

    request = Net::HTTP::Post.new(url)
    request["x-pw-accesstoken"] = ENV['PROSPERWORKS_KEY']
    request["x-pw-application"] = 'developer_api'
    request["x-pw-useremail"] = 'felipe@cpa.coop'
    request["content-type"] = 'application/json'
    request.body = "{\n  \"name\":\"" + org.legal_name + "\"\n}"

    response_from_legal_name = http.request(request)
    puts "Response from legal name:"
    puts response_from_legal_name.read_body

    request.body = "{\n  \"name\":\"" + org.common_name + "\"\n}"
    response_from_common_name = http.request(request)
    puts "Response from common name:"
    puts response_from_common_name.read_body
binding.pry

    if response_from_legal_name = JSON.parse(response_from_legal_name.body)[0]

      if (response_from_legal_name["address"] == nil && org.primary_building_address && org.primary_building_address[:street_address].length > 0) || (response_from_legal_name["address"]["street"] == nil && org.primary_building_address && org.primary_building_address[:street_address].length > 0)
        #add primary building address to PW

        url = URI("https://api.prosperworks.com/developer_api/v1/companies/" + response_from_legal_name['id'].to_s)

        http = Net::HTTP.new(url.host, url.port)
        http.use_ssl= true

        request = Net::HTTP::Put.new(url)
        request["x-pw-accesstoken"] = ENV['PROSPERWORKS_KEY']
        request["x-pw-application"] = 'developer_api'
        request["x-pw-useremail"] = 'felipe@cpa.coop'
        request["content-type"] = 'application/json'
        request.body = "{\n \"address\": {\"street\": \"" + org.primary_building_address[:street_address] +
                               "\", \"city\": \"" + org.primary_building_address[:city] +
                               "\", \"state\": \"" + org.primary_building_address[:state] +
                               "\", \"postal_code\": \"" + org.primary_building_address[:zip].to_s + "\"}\n}"

        response = http.request(request)
        puts response.read_body
binding.pry
      end

    elsif response_from_common_name = JSON.parse(response_from_common_name.body)[0]

      if (response_from_common_name["address"] == nil && org.primary_building_address && org.primary_building_address[:street_address].length > 0) || (response_from_common_name["address"]["street"] == nil && org.primary_building_address && org.primary_building_address[:street_address].length > 0)
        #add primary building address to PW

        url = URI("https://api.prosperworks.com/developer_api/v1/companies/" + response_from_common_name['id'].to_s)

        http = Net::HTTP.new(url.host, url.port)
        http.use_ssl= true

        request = Net::HTTP::Put.new(url)
        request["x-pw-accesstoken"] = ENV['PROSPERWORKS_KEY']
        request["x-pw-application"] = 'developer_api'
        request["x-pw-useremail"] = 'felipe@cpa.coop'
        request["content-type"] = 'application/json'
        request.body = "{\n \"address\": {\"street\": \"" + org.primary_building_address[:street_address] +
                               "\", \"city\": \"" + org.primary_building_address[:city] +
                               "\", \"state\": \"" + org.primary_building_address[:state] +
                               "\", \"postal_code\": \"" + org.primary_building_address[:zip].to_s + "\"}\n}"

        response = http.request(request)
        puts response.read_body
binding.pry
      end

    else
      puts "No match found in PW for this organization."
    end

  end

end

task :create_people => :environment do

  people = Contact.all

  people.each do |person|

    url = URI("https://api.prosperworks.com/developer_api/v1/people/search")

    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl= true

    request = Net::HTTP::Post.new(url)
    request["x-pw-accesstoken"] = ENV['PROSPERWORKS_KEY']
    request["x-pw-application"] = 'developer_api'
    request["x-pw-useremail"] = 'felipe@cpa.coop'
    request["content-type"] = 'application/json'
    request.body = "{\n  \"name\":\"" + person.first_name + " " + person.last_name + "\"\n}"
    response = http.request(request)
    puts response.body

    if response_as_json = JSON.parse(response.body)[0] == nil

      url = URI("https://api.prosperworks.com/developer_api/v1/people")

      http = Net::HTTP.new(url.host, url.port)
      http.use_ssl= true

      request = Net::HTTP::Post.new(url)
      request["x-pw-accesstoken"] = ENV['PROSPERWORKS_KEY']
      request["x-pw-application"] = 'developer_api'
      request["x-pw-useremail"] = 'felipe@cpa.coop'
      request["content-type"] = 'application/json'
      request.body = "{\n  \"name\":\"" + person.first_name + " " + person.last_name + "\"\n}"

      response = http.request(request)
      puts response.read_body
    # binding.pry
    end

  end

end

task :update_people => :environment do

  people = Contact.all

  people.each do |person|

    url = URI("https://api.prosperworks.com/developer_api/v1/people/search")

    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl= true

    request = Net::HTTP::Post.new(url)
    request["x-pw-accesstoken"] = ENV['PROSPERWORKS_KEY']
    request["x-pw-application"] = 'developer_api'
    request["x-pw-useremail"] = 'felipe@cpa.coop'
    request["content-type"] = 'application/json'
    request.body = "{\n  \"name\":\"" + person.first_name + " " + person.last_name + "\"\n}"
    response = http.request(request)
    puts response.body
# binding.pry

    if response_as_json = JSON.parse(response.body)[0]

      # puts response_as_json
      phones_array = response_as_json['phone_numbers'].map {|p| p["category"]}
      emails_array = response_as_json['emails'].map {|p| p["category"]}

      if phones_array.include?("mobile") == false && person.cell_phone.length > 0 && person.cell_phone != person.office_phone
        puts "add mobile!"

        url = URI("https://api.prosperworks.com/developer_api/v1/people/" + response_as_json['id'].to_s)

        http = Net::HTTP.new(url.host, url.port)
        http.use_ssl= true

        request = Net::HTTP::Put.new(url)
        request["x-pw-accesstoken"] = ENV['PROSPERWORKS_KEY']
        request["x-pw-application"] = 'developer_api'
        request["x-pw-useremail"] = 'felipe@cpa.coop'
        request["content-type"] = 'application/json'
        request.body = "{\n \"phone_numbers\": [" + response_as_json["phone_numbers"].first.to_json.to_s + ", {\"number\": \"" + person.cell_phone + "\", \"category\": \"mobile\"}]\n}"

# binding.pry
        response = http.request(request)
        puts response.read_body
      end

      if phones_array.include?("work") == false && person.office_phone.length > 0 && person.cell_phone != person.office_phone
        puts "add work phone!"

        url = URI("https://api.prosperworks.com/developer_api/v1/people/" + response_as_json['id'].to_s)

        http = Net::HTTP.new(url.host, url.port)
        http.use_ssl= true

        request = Net::HTTP::Put.new(url)
        request["x-pw-accesstoken"] = ENV['PROSPERWORKS_KEY']
        request["x-pw-application"] = 'developer_api'
        request["x-pw-useremail"] = 'felipe@cpa.coop'
        request["content-type"] = 'application/json'
        request.body = "{\n \"phone_numbers\": [" + response_as_json["phone_numbers"].first.to_json.to_s + ", {\"number\": \"" + person.office_phone + "\", \"category\": \"work\"}]\n}"

# binding.pry
        response = http.request(request)
        puts response.read_body

      end

      if emails_array.length == 0
        puts "add work email!"

        url = URI("https://api.prosperworks.com/developer_api/v1/people/" + response_as_json['id'].to_s)

        http = Net::HTTP.new(url.host, url.port)
        http.use_ssl= true

        request = Net::HTTP::Put.new(url)
        request["x-pw-accesstoken"] = ENV['PROSPERWORKS_KEY']
        request["x-pw-application"] = 'developer_api'
        request["x-pw-useremail"] = 'felipe@cpa.coop'
        request["content-type"] = 'application/json'
        request.body = "{\n \"emails\": [{\"email\": \"" + person.email + "\", \"category\": \"work\"}]\n}"

# binding.pry
        response = http.request(request)
        puts response.read_body
      end

      if emails_array.length != 0 && person.email != response_as_json['emails'][0]['email'] && response_as_json['emails'][0]['category'] != "other"
        puts "add other email!"

        url = URI("https://api.prosperworks.com/developer_api/v1/people/" + response_as_json['id'].to_s)

        http = Net::HTTP.new(url.host, url.port)
        http.use_ssl= true

        request = Net::HTTP::Put.new(url)
        request["x-pw-accesstoken"] = ENV['PROSPERWORKS_KEY']
        request["x-pw-application"] = 'developer_api'
        request["x-pw-useremail"] = 'felipe@cpa.coop'
        request["content-type"] = 'application/json'
        request.body = "{\n \"emails\": [" + response_as_json["emails"].first.to_json.to_s + ", {\"email\": \"" + person.email + "\", \"category\": \"other\"}]\n}"

# binding.pry
        response = http.request(request)
        puts response.read_body

      end

      if response_as_json['address'] != nil && response_as_json['address']['street'] != nil && response_as_json['address']['street'].length == 0 && person.organization.primary_building_address && person.organization.primary_building_address[:street_address].length > 0
        puts "add primary address!"

        url = URI("https://api.prosperworks.com/developer_api/v1/people/" + response_as_json['id'].to_s)

        http = Net::HTTP.new(url.host, url.port)
        http.use_ssl= true

        request = Net::HTTP::Put.new(url)
        request["x-pw-accesstoken"] = ENV['PROSPERWORKS_KEY']
        request["x-pw-application"] = 'developer_api'
        request["x-pw-useremail"] = 'felipe@cpa.coop'
        request["content-type"] = 'application/json'
        request.body = "{\n \"address\": {\"street\": \"" + person.organization.primary_building_address[:street_address] +
                                     "\", \"city\": \"" + person.organization.primary_building_address[:city] +
                                     "\", \"state\": \"" + person.organization.primary_building_address[:state] +
                                     "\", \"postal_code\": \"" + person.organization.primary_building_address[:zip].to_s + "\"}\n}"

# binding.pry
        response = http.request(request)
        puts response.read_body
      end

    end

  end

end
