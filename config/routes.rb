Rails.application.routes.draw do
	
	default_url_options :host => "youp0wn.com"

  get 'sessions/new'


 match '/users/json', to: 'users#json', :via => :get

  resources :challenges, only: [:index, :create, :edit, :new, :update]
  resources :contests
  resources :categories
  resources :users
  resources :password_resets,     only: [:new, :create, :edit, :update]
  resources :account_activations, only: [:edit]

  resources :contests do
    #member do
     #  put "like", to: "products#upvote"
     #end
    resources :challenges, only: :show do
        post '/flag', to: "challenges#flag"
	post '/download', to: "challenges#download"
    end
    resources :teams do
          get    '/join/:token',   to: 'teams#join', as: :join
    end
    get '/image', to: "contests#image"
   end
 

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
    root 'static#home'
    match '/signup', :to => 'users#new', :via => :get
    match '/signup', :to => 'users#create', :via => :post
    
    get    '/login',   to: 'sessions#new'
    post   '/login',   to: 'sessions#create'
    delete '/logout',  to: 'sessions#destroy'

   # resources :contests do
    #  get '/image', to: "contests#image"
   # end
end
