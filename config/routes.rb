# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  match '/401' => 'errors#error401', via: :all
  match '/404' => 'errors#error404', via: :all

  get '/auth/:provider/callback', to: 'sessions#create'
  get '/log_in', to: 'sessions#log_in'
  get '/log_out', to: 'sessions#log_out'
  # This is used for the developer backend.
  post '/auth/:provider/callback', to: 'sessions#create' if Rails.env.development?

  resources :polls, only: [:show] do
    resources :ballots, only: %i[create new show edit update]
  end

  root to: 'home#show'

  # Missing route to 404.
  root to: 'application#not_found'
end
