# frozen_string_literal: true

Rails.application.routes.draw do
  require 'rack'
  require 'sidekiq/web'
  require 'ffaker'
  mount Sidekiq::Web => '/sidekiq'
  devise_for :users
  root 'home#index'

  resources :articles do
    resources :comments
    get :download_pdf
  end

  resources :categories do
    resources :subcategories
  end

  resources :users do
    patch :update_from_menu
  end
end
