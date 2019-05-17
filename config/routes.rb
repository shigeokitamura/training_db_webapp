Rails.application.routes.draw do
  root 'courses#top'
  get '/search', to: 'courses#search'
  get '/show/:id', to: 'courses#show', as: 'course_show'
  get '/new', to: 'courses#new'
  get '/delete/:id', to: 'courses#delete', as: 'course_delete'

  resources :courses

  get '/sign_up', to: 'users#new'
  resources :users
end
