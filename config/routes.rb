# frozen_string_literal: true

# This file defines the applications routes
Rails.application.routes.draw do
  devise_for :users

  root to: 'news#index'
  get '/refine', controller: 'news', action: 'refine'
  get '/posts/user', controller: 'posts', action: 'user'

  resources :posts do
    resources :comments
  end
end
