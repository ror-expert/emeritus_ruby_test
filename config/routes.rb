Rails.application.routes.draw do
  resources :school_admins

  resources :schools do
    resources :courses
  end

  resources :courses, only: [] do
    resources :batches do 
      get :classmates
      resources :students, only: [:index, :new, :create] do
        post :enrollment
        put  :accept
        put  :reject
      end
    end
  end

  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "dashboard#index"
end
