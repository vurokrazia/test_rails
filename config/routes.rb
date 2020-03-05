Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  scope "(:locale)", locale: /es|en/ do
    namespace :api, defaults: {format: "json"}  do
      namespace :v1 do
        resources :activities, only: [:index, :create, :update, :show]
        resources :babies, only: [:index, :create, :update, :show]
        get "babies/:id/activity_logs", to: "babies#activity_logs" 
        resources :assistants, only: [:index, :create, :update, :show]
        resources :activity_logs, only: [:index, :create, :update, :show]
      end
    end
  end
end
