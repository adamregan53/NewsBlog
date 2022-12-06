Rails.application.routes.draw do
  devise_for :users

  get 'news/index'
  root to: "news#index"

  get '/refine', :controller=>'news', :action=>'refine'


  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
