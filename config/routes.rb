Rails.application.routes.draw do
  get 'users/show'
  devise_for :users,
    controllers: { registrations: 'registrations' } 
  get root 'top#index'
  resources :users,only:[:show]
end
