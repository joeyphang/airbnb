Rails.application.routes.draw do
  resources :passwords, controller: "clearance/passwords", only: [:create, :new]
  resource :session, controller: "clearance/sessions", only: [:create]

  resources :users, controller: "users", only: [:create] do
    resource :password,
    controller: "clearance/passwords",
    only: [:create, :edit, :update]
  end

  get "/sign_in" => "clearance/sessions#new", as: "sign_in"
  delete "/sign_out" => "clearance/sessions#destroy", as: "sign_out"
  get "/sign_up" => "clearance/users#new", as: "sign_up"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "welcome#index"

  ## creates all crud restful routes
  resources :listings do 
    resources :reservations

  end

#   resources :reservations do 
#     resources :payments

# end

patch 'listings/:id/verify' => "listings#verify", as: 'verify'

resources :reservations, only: [:create, :new, :show]

resources :users, controller:"users", only: [:edit, :update, :show]
##resources :users, only: [:edit, :update, :show]

get 'reservations/:id/payments/new' => "payments#new", as: 'new_payment'
post 'reservations/:id/payments/checkout' => "payments#checkout", as: 'payment_checkout'



end
