Rails.application.routes.draw do
  root 'admin/sessions#new'

  namespace :admin do
    get 'login', to: 'sessions#new'
    post 'login', to: 'sessions#create'
    delete 'logout', to: 'sessions#destroy'
    
    resources :gift_codes, only: [:index, :create]
    root 'gift_codes#index'
  end

  resources :gift_codes, only: [:index, :create]

  if Rails.env.development?
    require 'sidekiq/web'
    mount LetterOpenerWeb::Engine, at: '/letter_opener'
    mount Sidekiq::Web, at: '/sidekiq'
  end
end