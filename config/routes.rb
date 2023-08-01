Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :admin_users
  devise_for :users,
    controllers: { registrations: 'registrations' } 
  root 'top#index'
  resources :users, only: [:show]
  resources :events, only: [:index, :show] do
    collection do
      get 'search'
    end
    resources :event_listings, only: [:show, :create, :edit, :update, :destroy]
  end
  resources :event_registrations, only: [:create, :destroy]
  resources :chat_rooms, only: [:create, :show]
end
