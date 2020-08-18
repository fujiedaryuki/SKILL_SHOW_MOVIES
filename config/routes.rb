Rails.application.routes.draw do
  get 'users/new'
  get 'users/create'
  root 'welcome#top'
  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'
  resources :users, only: %i[new create]
  resources :videos do
    resources :comments, only: %i[create edit update destroy], shallow: true
    collection do
      get :my_videos
      get :likes
    end
  end
  resources :likes, only: %i[create destroy]
  resource :profile, only: %i[show edit update]
end
