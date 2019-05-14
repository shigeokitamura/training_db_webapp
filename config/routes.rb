Rails.application.routes.draw do
  root 'courses#top'
  get '/search', to: 'courses#search'
  get '/show/:id', to: 'courses#show', as: 'courses_show'
  get '/delete/:id', to: 'courses#delete', as: 'courses_delete'
end
