Rails.application.routes.draw do

  # devise_for :users
  

  devise_for :users, controllers: { registrations: 'users/registrations' }

  
  
  root to: "events#index"

  # root "/users/sign_up"
  # get "/users/sign_up" => "users/registrations#new"
  
  
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
  
  

end
