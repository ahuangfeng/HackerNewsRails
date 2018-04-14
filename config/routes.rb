Rails.application.routes.draw do
  resources :users
  resources :contributions
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'contributions#index'
  
  #get 'submit', to: 'contributions#new'
  #post 'submit', to: 'contributions#create'

end
