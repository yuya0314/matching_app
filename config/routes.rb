Rails.application.routes.draw do
  get 'event_listings/new'
  devise_for :users,
    controllers: { registrations: 'registrations' } 
  get root 'top#index'
  resources :users,only:[:show]
  resources :events
  resources :event_listings
end
