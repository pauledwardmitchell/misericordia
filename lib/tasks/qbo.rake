desc "This task sends invoice emails"

task :send_invoice_emails => :environment do

  qbo_api = QboApi.new(access_token: Qbo.first.access_token, realm_id: Qbo.first.realm_id)
  qbo_api.class.production = true

  @all_invoices = qbo_api.all :invoices
  @first_invoice = @all_invoices.first

  url = URI("https://quickbooks.api.intuit.com/v3/company/" + qbo_api.realm_id + "/invoice/" + @first_invoice["Id"] + "/send")

  request = Net::HTTP::Post.new(url)

  response = http.request(request)

  puts response.read_body

end
