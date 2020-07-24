Rails.application.routes.draw do

  root to: 'users#register'
  get 'users/index'
  get 'users/register'
  get 'users/login'
  post 'users/create_user'
  get 'users/account_activation'
  patch 'users/update_password'
  post 'users/login_user'
  post 'users/logout'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
