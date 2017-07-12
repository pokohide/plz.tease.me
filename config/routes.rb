Rails.application.routes.draw do

  root to: 'root#index'
  devise_for :users, path_names: { sign_out: 'login', sign_out: 'logout' },
    controllers: { omniauth_callbacks: 'omniauth_callbacks' }

  resources :slides, only: [:index, :show]

  namespace :admin do
    resources :slides, only: [:index, :new, :create, :edit, :update, :destroy]
  end

  get 'upload', to: 'admin/slides#new', as: :upload
end
