Rails.application.routes.draw do
  # get 'comments/index'
  # get 'comments/edit'
  resources :users
  resources :contributions
  resources :replies


  resources :contributions, except: :index do
    resources :comments, only: [:create, :edit, :update, :destroy], except: :index do
      resources :replies, only: [:create, :edit, :update, :destroy]
    end
    post :upvote, on: :member
    post :upvotecomment, on: :member
    post :upvotereply, on: :member


  end
  
  resources :comments, except: :index do
    post :downvotecomment, on: :member
  end
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'contributions#index'
  
  get '/auth/:provider/callback', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'
  get '/comments' => 'comments#index'
  get '/comments/:id' => 'comments#show'
  post '/comments/:id' => 'replies#create'
  post '/replies/:id' => 'replies#createWithParent'
  get '/replies/:id' => 'replies#show'
  match '/replies/:id' => 'replies#destroy', :via => :delete
  # post '/replies/:id' => 'replies#create'
  #s'hauria de canviar per un altre metode

  #api
  namespace :api do
    namespace :v1 do
      get 'contributions' => 'contributions#index'
      resources :contributions, except: :index do
        resources :comments, only: [:create, :edit, :update, :destroy], except: :index do
          resources :replies, only: [:create, :edit, :update, :destroy]
        end
        post :upvote, on: :member
        post :upvotecomment, on: :member
        post :upvotereply, on: :member
      end
  
      resources :comments, except: :index do
        post :downvotecomment, on: :member
      end
      
    end
  end
  
end
