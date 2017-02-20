Rails.application.routes.draw do
  resources :users, only: [:new, :create, :show, :index]
  resource :session, only: [:new, :create, :destroy]

  resources :goals, only: [:new, :create, :edit, :update, :destroy, :show, :index]
end
