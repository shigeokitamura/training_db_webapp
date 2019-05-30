Rails.application.routes.draw do
  # courses
  root 'courses#top'
  get '/search', to: 'courses#search'
  get '/show/:id', to: 'courses#show', as: 'course_show'
  get '/new', to: 'courses#new'
  get '/delete/:id', to: 'courses#delete', as: 'course_delete'
  resources :courses

  # users
  get '/signup', to: 'users#new'
  get '/user', to: 'users#show', as: 'user_show'
  resources :users

  # sessions
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  # orders
  resources :orders, only: [:create, :destroy]

  # API
  namespace 'api' do
    namespace 'v1' do
      resources :courses
      resources :orders, only: [:index, :create, :destroy]
    end
  end
end
