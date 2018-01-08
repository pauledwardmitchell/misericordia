desc "This task sends invoice emails"

task :renew_access => :environment do

  qbo_credentials = Qbo.first

  client = Rack::OAuth2::Client.new(identifier: QBO_CLIENT_ID,
                                    secret: QBO_CLIENT_SECRET,
                                    redirect_uri: ENV["QBO_REDIRECT_URI"],
                                    authorization_endpoint: "https://appcenter.intuit.com/connect/oauth2",
                                    token_endpoint: "https://oauth.platform.intuit.com/oauth2/v1/tokens/bearer"
                                    )

  client.refresh_token = qbo_credentials.refresh_token

  if resp = client.access_token!
    qbo_credentials.access_token = resp.access_token
    qbo_credentials.refresh_token = resp.refresh_token
    qbo_credentials.save
  end

end


# task :send_invoice_emails => :environment do

#   # qbo_api = QboApi.new(access_token: Qbo.first.access_token, realm_id: Qbo.first.realm_id)
#   # qbo_api.class.production = true

#   # @all_invoices = qbo_api.all :invoices
#   # @first_invoice = @all_invoices.first

#   # url = URI("https://quickbooks.api.intuit.com/v3/company/" + qbo_api.realm_id + "/invoice/" + @first_invoice["Id"] + "/send")

#   # http = Net::HTTP.new(url.host, url.port)
#   # http.use_ssl= true

#   # request = Net::HTTP::Post.new(url)

#   # response = http.request(request)

#   # puts response.read_body

# end

