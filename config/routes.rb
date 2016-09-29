Rails.application.routes.draw do
  namespace :api do
    namespace :v1, defaults: {format: :json} do
      resources :users, only: [:create, :index, :show]
    end
  end
end
