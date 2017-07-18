require 'sidekiq/web'
Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq'

  root to: 'root#index'
  devise_for :users, path_names: { sign_out: 'login', sign_out: 'logout' },
    controllers: { omniauth_callbacks: 'omniauth_callbacks' }

  # get '/mypage', to: 'users#mypage', as: :mypage
  resources :tags, only: [:index, :show]
  resources :users, only: [:index, :show]

  resources :slides, only: [:index, :show] do
    resources :comments, only: [:create, :destroy]
    collection do
      get 'tags', to: 'slides#tag_cloud', as: :tags
      get 'tag/:tag_name', to: 'slides#tag', as: :tag
    end
  end

  namespace :admin do
    resources :slides, only: [:index, :new, :create, :edit, :update, :destroy]
  end

  get 'upload', to: 'admin/slides#new', as: :upload
  post 'upload-pdf', to: 'admin/slides#upload_pdf', as: :upload_pdf
end
