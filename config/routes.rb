Rails.application.routes.draw do
  get "up" => "rails/health#show", :as => :rails_health_check

  root "home#index"
  post "login_cliente", to: "home#login_cliente", as: :login_cliente
  post "login_admin", to: "home#login_admin", as: :login_admin
  post "logout", to: "home#logout", as: :logout

  get "contato" => "home#contato"
  get "carrinho" => "home#carrinho"
  get "minha-conta" => "home#minha_conta"

  get "produtos" => "produtos#index"
end
