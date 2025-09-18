Rails.application.routes.draw do
  # Health check
  get "up" => "rails/health#show", :as => :rails_health_check

  # Home
  root "home#index", :as => :root
  get "login" => "home#login", :as => :login
  get "contato" => "home#contato", :as => :contato
  get "perfil" => "home#perfil", :as => :perfil

  # Session
  post "login-cliente" => "session#login_cliente", :as => :login_cliente
  post "login-vendedor" => "session#login_vendedor", :as => :login_vendedor
  post "login-admin" => "session#login_admin", :as => :login_admin
  post "logout" => "session#logout", :as => :logout

  # Produtos
  get "produtos/new" => "produtos#new", :as => :new_produto
  post "produtos" => "produtos#create", :as => :create_produto
  get "produtos/:id/edit" => "produtos#edit", :as => :edit_produto
  put "produtos/:id" => "produtos#update", :as => :update_produto
  delete "produtos/:id" => "produtos#destroy", :as => :delete_produto
  get "produtos" => "produtos#index", :as => :produtos

  # Carrinho
  get "carrinho" => "carrinho#index", :as => :carrinho
  post "carrinho/adicionar-ao-carrinho" => "carrinho#add_to_carrinho", :as => :add_to_carrinho
  delete "carrinho/limpar-carrinho" => "carrinho#clean_carrinho", :as => :clean_carrinho

  # Compras
  post "compras" => "compras#create", :as => :create_compra
  get "compras" => "compras#index", :as => :compras
  get "compras/:id" => "compras#show", :as => :compra
end
