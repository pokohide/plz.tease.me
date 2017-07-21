require 'sidekiq/web'
Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq'
  mount ActionCable.server => '/cable'
  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?

  root to: 'root#index'
  devise_for :users, path_names: { sign_in: 'login', sign_out: 'logout' },
                     controllers: { omniauth_callbacks: 'omniauth_callbacks' }

  resources :tags, only: %i[index show]
  resources :users, only: [:index]

  resources :slides, only: %i[index show] do
    resources :comments, only: %i[create destroy]
  end

  namespace :admin do
    resources :slides, only: %i[index create edit update destroy]
  end

  get '/c/:category', to: 'slides#category', as: :category
  get '/featured', to: 'root#categories', as: :categories
  get '/account', to: 'users#account', as: :account
  get '/upload', to: 'admin/slides#new', as: :upload
  post '/upload-pdf', to: 'admin/slides#upload_pdf', as: :upload_pdf
  post '/process-pdf', to: 'admin/slides#process_pdf', as: :process_pdf
  get '/:username', to: 'users#show', as: :user
  get '/embeds/:slug', to: 'embeds#show', as: :embed
end
