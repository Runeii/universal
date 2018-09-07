Rails.application.routes.draw do
  resources :playlists
  resources :links
  resources :tracks
  resources :albums
  resources :artists

  scope 'api', defaults: { format: :json } do
    resources :links
    match "link/:url" => "links#parse_url", :constraints => {:url => /.*/}, via: [:get]
    resources :tracks
    resources :albums
    resources :artists
  end

  mount ActionCable.server => '/cable'
  
  root 'pages#index'
  get '/:page', to: 'pages#index'
end
