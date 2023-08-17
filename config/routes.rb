Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :admin_users
  devise_for :users,
    controllers: { registrations: 'registrations' } 
  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
  end
  root 'top#index'
  resources :users, only: [:show]
  resources :events, only: [:index, :show] do
    collection do
      get 'search'
      get 'filtered_index'
    end
    resources :event_listings, only: [:show, :create, :edit, :update, :destroy]
  end
  resources :event_registrations, only: [:create, :destroy]
  resources :chat_rooms, only: [:create, :show]
end
