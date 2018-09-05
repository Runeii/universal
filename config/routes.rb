Rails.application.routes.draw do
  resources :links
  resources :tracks
  resources :albums
  resources :artists
  mount ActionCable.server => '/cable'
  
  root 'pages#index'
  get '/:page', to: 'pages#index'
end
