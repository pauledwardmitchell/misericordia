Rails.application.routes.draw do
  root to: 'invoices#index'

  get '/oauth2', to: 'invoices#oauth2'
  get '/oauth2_redirect', to: 'invoices#oauth2_redirect'
  get '/quickbooks_oauth_callback', to: 'invoices#oauth_callback'
end
