class HomeController < ApplicationController
  def carrinho
    carrinho = Carrinho.first!
    render "carrinho", locals: {carrinho:}
  end
end
