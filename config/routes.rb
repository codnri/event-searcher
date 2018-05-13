Rails.application.routes.draw do
  # devise_for :users
  devise_for :users, controllers: { registrations: 'users/registrations' }

  mount StripeEvent::Engine, at: '/webhooks/stripe' # provide a custom path
 
  resources :users
    
  
  resources :attends
  
  resources :events do
  resources :attends
  
    #get '/events/:event_id/attends/subscribe', to: 'attends#subscribe'

  end
  # resources :events do
  #   :purchases
  # end
  
  
  root to: "events#index"
end
