Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :admin_users
  get 'event_listings/new'
  devise_for :users,
    controllers: { registrations: 'registrations' } 
  root 'top#index'
  resources :users,only:[:show]
  resources :events do
    collection do
      get 'search'
    end
  end
  resources :event_listings
  resources :event_registrations
end
