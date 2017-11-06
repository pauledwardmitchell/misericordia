Rails.application.routes.draw do
  devise_for :users
  root to: 'invoices#index'

  resources :contacts, only: [:index]
  resources :organizations, only: [:index]
  resources :customers, only: [:index, :show]

  get '/dashboard', to: 'customers#dashboard'
  get '/oauth2', to: 'invoices#oauth2'
  get '/oauth2_redirect', to: 'invoices#oauth2_redirect'
  get '/quickbooks_oauth_callback', to: 'invoices#oauth_callback'

  post '/webhook', to: 'invoices#webhook'
end
