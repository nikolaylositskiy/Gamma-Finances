Rails.application.routes.draw do
  devise_for :users
  root :to => "users#index"
  resources :transactions
  get "home" => "welcome#index"
end
