Rails.application.routes.draw do
  # get 'comments/index'
  # get 'comments/edit'

  resources :users
  resources :contributions

  resources :contributions, except: :index do
    resources :comments, only: [:create, :edit, :update, :destroy]
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'contributions#index'
  
  get '/auth/:provider/callback', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'
  get '/comments' => 'comments#index'

  #s'hauria de canviar per un altre metode
  match 'contributions/:id/vote' => 'contributions#vote', :via => :get

end
