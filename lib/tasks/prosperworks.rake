desc "This task updates people in PW"

task :update_people do

  url = URI("https://api.prosperworks.com/developer_api/v1/people/search")

  http = Net::HTTP.new(url.host, url.port)
  http.use_ssl= true

  request = Net::HTTP::Post.new(url)
  request["x-pw-accesstoken"] = ENV['PROSPERWORKS_KEY']
  request["x-pw-application"] = 'developer_api'
  request["x-pw-useremail"] = 'felipe@cpa.coop'
  request["content-type"] = 'application/json'
  request.body = "{\n  \"name\":\"Aaron Siirila\"\n}"

  response = http.request(request)

  puts response.read_body

end
