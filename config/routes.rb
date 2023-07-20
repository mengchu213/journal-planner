Rails.application.routes.draw do
  
  root 'home#home'

  resources :categories do 
    resources :tasks
  end

  resources :home
  resource :session, only: [:new, :create, :destroy]

  resources :users
  get "signup" => "users#new" 
  get "signin" => "sessions#new"
end
