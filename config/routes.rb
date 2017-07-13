require 'sidekiq/web'
Rails.application.routes.draw do
  get 'tags/index'

  get 'tags/show'

  mount Sidekiq::Web => '/sidekiq'

  root to: 'root#index'
  devise_for :users, path_names: { sign_out: 'login', sign_out: 'logout' },
    controllers: { omniauth_callbacks: 'omniauth_callbacks' }

  # get '/mypage', to: 'users#mypage', as: :mypage
  resources :tags, only: [:index, :show]

  resources :slides, only: [:index, :show] do
    collection do
      get 'tags', to: 'slides#tag_cloud', as: :tags
      get 'tag/:tag_name', to: 'slides#tag', as: :tag
    end
  end

  namespace :admin do
    resources :slides, only: [:index, :new, :create, :edit, :update, :destroy]
  end

  get 'upload', to: 'admin/slides#new', as: :upload
end
