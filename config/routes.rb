Rails.application.routes.draw do
  root 'courses#top'
  get '/search', to: 'courses#search'
end
