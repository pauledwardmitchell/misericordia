class PwApi

  def initialize

  end

  def set_headers(request)
    request["x-pw-accesstoken"] = ENV['PROSPERWORKS_KEY']
    request["x-pw-application"] = 'developer_api'
    request["x-pw-useremail"] = 'felipe@cpa.coop'
    request["content-type"] = 'application/json'
    request
  end

end
