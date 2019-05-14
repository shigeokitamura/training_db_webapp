Rails.application.routes.draw do
  root 'courses#top'
  get '/search', to: 'courses#search'
  get '/show/:id', to: 'courses#show', as: 'course_show'
  get '/new', to: 'courses#new'
  get '/delete/:id', to: 'courses#delete', as: 'course_delete'
  get '/deleted', to: 'courses#deleted'

  resources :courses
end
