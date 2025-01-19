Rails.application.routes.draw do
  get 'search', to: 'search#index', as: 'search'
  
  resources :tags
  resources :recipes do
    collection do
      post :search
      get "my"
    end
    member do
      post "like", to: "recipes#like"
      delete "unlike", to: "recipes#unlike"
    end
  end
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }

  #  get "home/index"
  get "home/about"
  root "recipes#index"
  get "up" => "rails/health#show", as: :rails_health_check

end


  
