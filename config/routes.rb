Rails.application.routes.draw do
  resources :users
  resources :contributions
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'contributions#index'
  
  get '/auth/:provider/callback', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  #s'hauria de canviar per un altre metode
  match 'contributions/:id/vote' => 'contributions#vote', :via => :get

end
