Rails.application.routes.draw do
  root 'courses#top'
  get '/search', to: 'courses#search'
  get '/show/:id', to: 'courses#show', as: 'course_show'
  get '/new', to: 'courses#new'
  get '/delete/:id', to: 'courses#delete', as: 'course_delete'
  resources :courses

  get '/signup', to: 'users#new'
  resources :users

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
end
