class InvoicesController < ApplicationController

  skip_before_action :verify_authenticity_token, only: [:webhook]

  def index
  end

  def oauth2
    session[:state] = SecureRandom.uuid
    # binding.pry
    @client = Rack::OAuth2::Client.new(identifier: QBO_CLIENT_ID,
                                       secret: QBO_CLIENT_SECRET,
                                       redirect_uri: ENV["QBO_REDIRECT_URI"],
                                       authorization_endpoint: "https://appcenter.intuit.com/connect/oauth2",
                                       token_endpoint: "https://oauth.platform.intuit.com/oauth2/v1/tokens/bearer"
                                     )
    # binding.pry
    # callback = quickbooks_oauth_callback_url
    # token = QB_OAUTH_CONSUMER.get_request_token(:oauth_callback => callback)
    # session[:qb_request_token] = token
    # redirect_to("https://appcenter.intuit.com/Connect/Begin?oauth_token=#{token.token}") and return
  end

  def oauth2_redirect
    # binding.pry
    state = params[:state]
    error = params[:error]
    code = params[:code]
    if state == session[:state]
      client = Rack::OAuth2::Client.new(identifier: QBO_CLIENT_ID,
                                       secret: QBO_CLIENT_SECRET,
                                       redirect_uri: ENV["QBO_REDIRECT_URI"],
                                       authorization_endpoint: "https://appcenter.intuit.com/connect/oauth2",
                                       token_endpoint: "https://oauth.platform.intuit.com/oauth2/v1/tokens/bearer"
                                     )
        # binding.pry
      client.authorization_code = code
      if resp = client.access_token!
        session[:refresh_token] = resp.refresh_token
        session[:access_token] = resp.access_token
        session[:realm_id] = params[:realmId]

        qbo_credentials = Qbo.first
        qbo_credentials.access_token = resp.access_token
        qbo_credentials.realm_id = params[:realmId]
        qbo_credentials.save

        render 'index' #what do I want to render next?
      else
        "Something went wrong. Try the process again"
      end
    else
      "Error: #{error}"
    end
  end

  def pipeline
    @landscaping_contracts = LandscapingContract.where(cover_sheet_entered: false, active: true)
    @waste_contracts = WasteContract.where(cover_sheet_entered: false, active: true)
    @cleaning_contracts = CleaningContract.where(cover_sheet_entered: false, active: true)
  end

  def webhook
    puts "Params:"
    puts params
    puts " - - - - "
    puts params['updated_attributes']['status'][1]
    if params['updated_attributes']['status'][1] == "Won"
      puts "We won!!"
      #get params['id'] which is the opportunity id
        opportunity_id = params['ids'][0]
      #look up opportunity by its id
        response = find_opportunity(opportunity_id)
      #format object as json
        won_opportunity = JSON.parse(response.body)

        create_contract(won_opportunity)

    end

  end

  def all_contracts
    @landscaping_contracts = LandscapingContract.all
  end

  private

  def find_opportunity(id)
    url = URI("https://api.prosperworks.com/developer_api/v1/opportunities/" + id.to_s)

    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl= true

    request = Net::HTTP::Get.new(url)
    pw_api = PwApi.new
    request = pw_api.set_headers(request)

    response = http.request(request)
    response
  end

  def create_contract(won_opportunity)
    if won_opportunity['tags'].include?("landscaping")
      LandscapingContract.create(name: won_opportunity['name'],
                                 pw_organization_id: won_opportunity['company_id'])
    elsif won_opportunity['tags'].include?("trash") || won_opportunity['tags'].include?("waste")
      WasteContract.create(name: won_opportunity['name'],
                           pw_organization_id: won_opportunity['company_id'])
    elsif won_opportunity['tags'].include?("cleaning") || won_opportunity['tags'].include?("janitorial")
      CleaningContract.create(name: won_opportunity['name'],
                              pw_organization_id: won_opportunity['company_id'])
    elsif won_opportunity['tags'].include?("security")
      SecurityContract.create(name: won_opportunity['name'],
                              pw_organization_id: won_opportunity['company_id'])
    end
  end

end
