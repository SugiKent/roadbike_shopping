Rails.application.routes.draw do
  root 'welcome#index'

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  get "home", to: "home#index", as: "user_root"

  resources :products, only: %i(create)

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
