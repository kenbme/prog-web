class HomeController < ApplicationController
  def carrinho
    raise ForbiddenError unless current_user.cliente?

    carrinho = Carrinho.find_by!(usuario: current_user)
    render "carrinho", locals: {carrinho:}
  end

  def minha_conta
    render "minha_conta", locals: {usuario: current_user}
  end
end
