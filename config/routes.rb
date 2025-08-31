Rails.application.routes.draw do
  # Health check
  get "up" => "rails/health#show", :as => :rails_health_check

  # Home
  root "home#index", as: :root
  get "contato" => "home#contato", :as => :contato
  get "perfil" => "home#perfil", :as => :perfil

  # Session
  post "login-cliente" => "session#login_cliente", :as => :login_cliente
  post "login-admin" => "session#login_admin", :as => :login_admin
  post "logout" => "session#logout", :as => :logout

  # Produtos
  get "produtos" => "produtos#index", :as => :produtos

  # Carrinho
  get "carrinho" => "carrinho#index", :as => :carrinho
  post "carrinho/adicionar-ao-carrinho" => "carrinho#add_to_carrinho", :as => :add_to_carrinho
  delete "carrinho/limpar-carrinho" => "carrinho#clean_carrinho", :as => :clean_carrinho
end
