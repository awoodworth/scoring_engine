Rails.application.routes.draw do

  resources :guides
  get "dashboards/:action", controller: 'dashboards', as: 'dashboard'
  get "dashboards" => "dashboards#index"

  devise_for :users, controllers: { registrations: 'users' }
  resources :users, except: :show do
    get :admin, on: :member
  end
  devise_scope :user do
    get "login", to: "devise/sessions#new"
    get "logout", to: "devise/sessions#destroy"
  end

  resources :injects do
    resources :inject_responses
  end
  resources :inject_responses
  get "inject_responses/team/:user_id" => "inject_responses#team", as: :team_inject_responses

  root 'welcome#index'

end
