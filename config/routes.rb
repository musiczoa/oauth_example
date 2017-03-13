Rails.application.routes.draw do

  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
  get 'signout', to: 'sessions#destroy', as: 'signout'
  get 'payload', to: 'home#make_developer_payload', as: 'make_developer_payload'

  resources :sessions, only: [:create, :destroy]
  resource :home, only: [:show, :make_developer_payload]

  root to: 'home#show'

  match '*all' => 'application#cors_preflight_check', :via=> [:options], :constraints => { :method => 'OPTIONS' }
end
