Rails.application.routes.draw do
  get 'users/new'
  get 'users/create'
  root 'welcome#top'
  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'


  resources :users, only: %i[new create]
  resources :videos, only: %i[index]

  

end
