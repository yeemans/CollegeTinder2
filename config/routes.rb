Rails.application.routes.draw do
  get 'rooms/index'
  devise_for :users, controllers: {
        registrations: 'registrations',
        sessions: 'users/sessions'
  }
  
  resources :users
  resources :rooms do
    resources :messages
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  authenticated :user do
    root 'users#profile', as: :authenticated_root
  end
  root "home#index"
  get '/users/:id/profile', to: 'users#profile', :as => :profile
  get '/notifications', to: 'users#notifications', :as => :notfications
  patch '/users/:id/change_avatar', to: 'users#change_avatar', :as => :change_avatar
  
  post '/:sender_id/:receiver_id/send_request', to: 'users#send_request', :as => :send_request
  post '/:request_id/accept', to: 'users#accept_request', :as => :accept_request
  post '/:request_id/decline', to: 'users#decline_request', :as => :decline_request

  get '/:id/message', to: 'users#message', :as => :message
  
end
