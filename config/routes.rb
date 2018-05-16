Rails.application.routes.draw do

  # devise_for :users
  

  devise_for :users, controllers: { registrations: 'users/registrations' }

  
  
  root to: "events#index"


  
  
  mount StripeEvent::Engine, at: '/webhooks/stripe' # provide a custom path
 
  resources :users
    
  
  resources :attends
  
  resources :events do
    resources :attends

  end
  # resources :events do
  #   :purchases
  # end
  
  

end
