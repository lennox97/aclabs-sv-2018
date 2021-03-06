Rails.application.routes.draw do
  mount ResqueWeb::Engine => "/resque_web"
  get 'dashboard/index'
  root to:'dashboard#index'

  resources :ratios
  resources :amounts
  resources :currencies do 
  	member do
  		post 'buy', to: 'currencies#buy'
      get 'open_modal', to:'currencies#open_modal'
  	end
    collection do
      get 'chart', to: 'currencies#gen_chart'
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/signup' =>'users#new'
  post '/signup' => 'users#create'

  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  get '/logout' => 'sessions#destroy'

  get '/welcome' => 'welcome#new'


end
