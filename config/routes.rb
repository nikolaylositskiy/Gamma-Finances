Rails.application.routes.draw do
  devise_for :users
  root to: 'welcome#index'
  resources :expenses do
    resources :transactions, only: [:index, :new, :create]
  end
  resources :transactions
end
