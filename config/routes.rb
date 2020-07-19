Rails.application.routes.draw do
  get 'users/new'
  get 'users/create'
  root 'welcome#top'
  resources :users, only: %i[new create]
  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'

  

end
