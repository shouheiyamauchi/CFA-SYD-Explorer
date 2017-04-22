Rails.application.routes.draw do
  root 'pages#home'
  get 'pages/test'
  get 'pages/test2'
  get 'pages/test3'
  get 'pages/test4'
  post 'pages/save_grid'

  get 'signup/parent'
  get 'signup/organiser'
  get 'signup/child'
  get 'signup/admin'
  post 'signup/create_user'

  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
