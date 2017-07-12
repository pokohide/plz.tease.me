Rails.application.routes.draw do
  root to: 'root#index'
  devise_for :users, path_names: { sign_out: 'login', sign_out: 'logout' }
end
