Rails.application.routes.draw do
  
  root "home#index"

  resources :categories do 
    resources :tasks
  end

  resources :home

  resources :users
  get "signup" => "users#new" 
end
