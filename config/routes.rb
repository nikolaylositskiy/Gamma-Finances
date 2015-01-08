Rails.application.routes.draw do
  devise_for :users
  resources :users
  root :to => "users#index"

  get "home" => "welcome#index"
end
