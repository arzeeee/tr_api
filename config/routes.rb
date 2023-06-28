# frozen_string_literal: true

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  get 'login', to: 'pages#login'
  post 'login', to: 'pages#sessions'
  get 'logout', to: 'pages#logout'
  get 'register', to: 'users#new'

  get 'dashboard', to: 'pages#dashboard'

  resources :users, only: %i[create index]
  resources :transactions, only: :index

  namespace :api do
    get 'withdraw', to: 'transactions#withdraw'
    get 'deposit', to: 'transactions#deposit'
    get 'transfer', to: 'transactions#transfer'
  end

  root 'pages#dashboard'
end
