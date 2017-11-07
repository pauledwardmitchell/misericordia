Rails.application.routes.draw do
  devise_for :users
  root to: 'invoices#index'

  resources :contacts, only: [:index]
  resources :organizations, only: [:index]
  resources :customers, only: [:index, :show]
  resources :landscaping_contracts, only: [:show, :edit]

  get '/dashboard', to: 'customers#dashboard'
  get '/pipeline', to: 'invoices#pipeline'

  get '/oauth2', to: 'invoices#oauth2'
  get '/oauth2_redirect', to: 'invoices#oauth2_redirect'
  get '/quickbooks_oauth_callback', to: 'invoices#oauth_callback'

  post '/webhook', to: 'invoices#webhook'
end
