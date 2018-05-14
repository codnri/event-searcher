Rails.application.routes.draw do

  # devise_for :users
  devise_for :users, controllers: { registrations: 'users/registrations' }
  devise_scope :user do
    post 'users/sign_up', to: 'devise/registrations#create'
  end
  
  # constraints ->  request { request.session[:user_id].present? } do
  # ログインしてる時のパス
    root to: "events#index"
  # end
  # ログインしてない時のパス
  # root "users/registrations#new"
  

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
