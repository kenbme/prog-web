Rails.application.routes.draw do
  get "up" => "rails/health#show", :as => :rails_health_check

  root "home#index"
  get "contato" => "home#contato"
  get "carrinho" => "home#carrinho"
  get "minha-conta" => "home#minha_conta"

  get "produtos" => "produtos#index"
end
