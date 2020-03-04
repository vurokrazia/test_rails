Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api, defaults: {format: "json"}  do
    namespace :v1 do
      resources :activities, only: [:index, :create, :update, :show, :destroy]
    end
  end
end
