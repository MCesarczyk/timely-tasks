Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  get "up" => "rails/health#show", as: :rails_health_check

  root "welcome#index"

  get "tasks/index"

  resources :welcome, only: [:index]

  resources :tasks, only: [:index, :show, :create, :update, :destroy] do
    collection do
      get :index
    end
  end
end
