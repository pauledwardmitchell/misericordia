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

end
