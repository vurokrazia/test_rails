Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  scope "(:locale)", locale: /es|en/ do
    devise_for :users
    root 'home#index'
    get "babies/:id/activity_logs", to: "babies#activity_logs" 
    resources :activities, expect: [:destroy]
    resources :babies, expect: [:destroy]
    resources :assistants, expect: [:destroy]
    resources :activity_logs, expect: [:destroy]
    namespace :api  do
      get "grettings", to: "grettings#index"
      namespace :v1 do
        get "babies/:id/activity_logs", to: "babies#activity_logs" 
        resources :activities, only: [:index, :create, :update, :show]
        resources :babies, only: [:index, :create, :update, :show]
        resources :assistants, only: [:index, :create, :update, :show]
        resources :activity_logs, only: [:index, :create, :update, :show]
      end
    end
  end
end