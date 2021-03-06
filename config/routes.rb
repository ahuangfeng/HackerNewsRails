Rails.application.routes.draw do
  resources :users
  resources :contributions
  resources :comments

  resources :contributions, except: :index do
    resources :comments, only: [:create, :edit, :update, :destroy]

    post :upvote, on: :member
    post :upvotecomment, on: :member
    post :destroy, on: :member

  end
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'contributions#index'
  
  get '/auth/:provider/callback', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'
  post '/comments/:id' => 'comments#createWithParent'

  #api
  namespace :api do
    namespace :v1 do
      resources :users, only: [:show, :create, :update, :destroy]
      resources :contributions, only: [:index, :show, :create, :update, :destroy] do # afegit aixo per a que no renderitzi els altres endpoints
        resources :comments, only: [:index, :show, :create, :update, :destroy] 
      end
      
      get 'users/:id/comments', to: 'users#threads'

      post 'contributions/:id/vote' => 'contributions#vote'
      post 'contributions/:id/unvote' => 'contributions#unvote'
      post 'contributions/:contribution_id/comments/:id/vote' => 'comments#vote'
      post 'contributions/:contribution_id/comments/:id/unvote' => 'comments#unvote'

      post 'contributions/:contribution_id/comments/:id/reply' => 'comments#replyComment'

      post 'login' => 'sessions#getSession'

    end
  end
  
end
