Rails.application.routes.draw do
  root to: 'invoices#index'

  get '/authenticate', to: 'invoices#authenticate'
  get '/quickbooks_oauth_callback', to: 'invoices#oauth_callback'
end
