Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api, defaults: {format: "json"}  do
    namespace :v1 do
      resources :activities, only: [:index, :create, :update, :show]
      resources :babies, only: [:index, :create, :update, :show]
      resources :assistants, only: [:index, :create, :update, :show]
    end
  end
end
