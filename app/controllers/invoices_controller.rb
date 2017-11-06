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

  def webhook
    puts response.read_body

    if response.body['updated_attributes']['status'][1] = "Won"
      puts "We won!!"
    end

  end

end
