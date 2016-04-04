Rails.application.routes.draw do

  get "dashboards/:action", controller: 'dashboards', as: 'dashboard'
  get "dashboards" => "dashboards#index"

  devise_for :users, controllers: { registrations: 'users' }, skip: [:password], path_names: { sign_in: 'login', sign_out: 'logout' }
  resources :users, except: :show do
    get :admin, on: :member
  end
  devise_scope :user do
    get "login", to: "devise/sessions#new"
    get "logout", to: "devise/sessions#destroy"
  end
  resources :settings

  resources :injects do
    resources :inject_responses
  end
  resources :inject_responses do
    get :summary, on: :collection
  end

  resources :guides

  root 'welcome#index'

end
