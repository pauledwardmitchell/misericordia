class PwApi

  def initialize

  end

  def get_request(url)
    request = Net::HTTP::Get.new(url)
    request = set_headers(request)
    request
  end

  def post_request(url)
    request = Net::HTTP::Post.new(url)
    request = set_headers(request)
    request
  end

  def all_opportunities
    url = URI("https://api.prosperworks.com/developer_api/v1/opportunities/search")
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl= true
    opportunities_request = post_request(url)
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
  end

  private

  def set_headers(request)
    request["x-pw-accesstoken"] = ENV['PROSPERWORKS_KEY']
    request["x-pw-application"] = 'developer_api'
    request["x-pw-useremail"] = 'felipe@cpa.coop'
    request["content-type"] = 'application/json'
    request
  end

  def post_request(url)
    request = Net::HTTP::Post.new(url)
    request = set_headers(request)
    request
  end
end
