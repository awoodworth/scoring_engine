Rails.application.routes.draw do

  get "dashboards/:action", controller: 'dashboards', as: 'dashboard'
  get "dashboards" => "dashboards#index"

  devise_for :users, controllers: { registrations: 'users' }, skip: [:password], path_names: { sign_in: 'login', sign_out: 'logout' }
  resources :users, except: :show
  devise_scope :user do
    get "login", to: "devise/sessions#new"
    get "logout", to: "devise/sessions#destroy"
  end
  resources :groups
  resources :settings, skip: :show

  resources :events do
    resources :flag_categories do
      collection do
        post :order_flags
      end
      member do
        get :move_up
        get :move_down
      end
    end
  end
  resources :flags, only: [] do
    member do
      post :check
      get :submissions
    end
  end
  resources :ctf, only: :index
  get "ctf/:flag_category_id" => "ctf#category", as: :ctf_flag_category

  resources :injects do
    resources :inject_responses
    member do
      get :available_now
    end
  end
  resources :inject_responses do
    get :summary, on: :collection
  end

  resources :guides

  root 'welcome#index'

end
