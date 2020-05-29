# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  devise_for :users
  resources :users, only: :show
  resources :games, only: %i[index show new create edit update destroy]
  resources :companies, only: %i[index show new create edit update destroy]
  get '/my_profile', to: 'users#show'
  root to: 'games#index'
end
