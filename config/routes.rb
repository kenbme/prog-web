Rails.application.routes.draw do
  get "up" => "rails/health#show", :as => :rails_health_check

  root "home#index", as: :root
  post "login-cliente" => "session#login_cliente", :as => :login_cliente
  post "login-admin" => "session#login_admin", :as => :login_admin
  post "logout" => "session#logout", :as => :logout

  get "contato" => "home#contato", :as => :contato
  get "carrinho" => "home#carrinho", :as => :carrinho
  get "minha-conta" => "home#minha_conta", :as => :minha_conta

  get "produtos" => "produtos#index", :as => :produtos

  post "carrinho/adicionar-ao-carrinho" => "carrinho#add_to_carrinho", :as => :add_to_carrinho
  delete "carrinho/limpar-carrinho" => "carrinho#clean_carrinho", :as => :clean_carrinho
end
