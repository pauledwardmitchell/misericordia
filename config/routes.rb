Rails.application.routes.draw do
  devise_for :users
  root to: 'invoices#index'

  resources :contacts, only: [:index]
  resources :organizations, only: [:index]
  resources :customers, only: [:index, :show]
  resources :landscaping_contracts
  resources :waste_contracts
  resources :cleaning_contracts
  resources :security_contracts
  resources :copier_contracts
  resources :solar_contracts
  resources :gas_contracts
  resources :electricity_contracts
  resources :monthly_contracts
  resources :members

  get '/dashboard', to: 'customers#dashboard'
  get '/pipeline', to: 'invoices#pipeline'
  get '/active_contracts', to: 'invoices#active_contracts'
  get '/2017', to: 'invoices#stats2017'

  get '/oauth2', to: 'invoices#oauth2'
  get '/oauth2_redirect', to: 'invoices#oauth2_redirect'
  get '/quickbooks_oauth_callback', to: 'invoices#oauth_callback'

  post '/webhook', to: 'invoices#webhook'
end
