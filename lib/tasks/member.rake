desc "This task creates members from pw objects"

task :create_members => :environment do

    url = URI("https://api.prosperworks.com/developer_api/v1/companies/search")
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl= true

    request = set_up_pw_post_request(url)
    request.body = "{\n  \"page_size\":200, \n  \"tags\":\"member\"\n}"
    response = http.request(request)
    member_organizations = JSON.parse(response.body)

    member_organizations.each do |org|
      Member.create(pw_id: org["id"], name: org["name"])
    end

end
