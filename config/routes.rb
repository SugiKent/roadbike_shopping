Rails.application.routes.draw do
  root 'welcome#index'

  devise_for :users, controllers: {
    omniauth_callbacks: "users/omniauth_callbacks"
  }
  devise_scope :user do
    delete :sign_out, to: 'devise/sessions#destroy', as: :destroy_user_session
  end
  get "home", to: "home#index", as: "user_root"

  resources :products, only: %i(create)
  resources :mypage, only: %i(index edit update)

  namespace :admin do
    resources :sites
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
