Rails.application.routes.draw do

  post 'pages/attend_event'

  resources :events do
    member do
      resources :attendances
    end
  end

  get 'contact', to: 'contact#index'
  post '/', to: 'contact#mail'

  get 'parent_pages/events'
  get 'parent_pages/children'
  get 'parent_pages/point_store'

  post 'events/approve'
  post 'events/reject'



  post 'parent_pages/approve'
  post 'parent_pages/reject'

  root 'pages#home'
  get 'pages/calendar'
  post 'pages/save_grid'

  get 'signup/parent'
  get 'signup/organiser'
  get 'signup/child'
  get 'signup/admin'
  post 'signup/create_user'

  get 'pages/test'

  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
