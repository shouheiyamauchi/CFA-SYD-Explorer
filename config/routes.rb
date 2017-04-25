Rails.application.routes.draw do
  resources :events do
    member do
      resources :attendances
    end
  end

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

  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
