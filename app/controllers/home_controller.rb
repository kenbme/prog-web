class HomeController < ApplicationController
  def login_cliente
    session[:usuario_id] = Usuario.find_by!(cargo: "cliente").id
  end

  def login_admin
    session[:usuario_id] = Usuario.find_by!(cargo: "admin").id
  end

  def logout
    session[:usuario_id] = nil
  end

  def carrinho
    raise ForbiddenError unless current_user.cliente?

    carrinho = Carrinho.find_by!(usuario: current_user)
    render "carrinho", locals: {carrinho:}
  end

  def minha_conta
    render "minha_conta", locals: {usuario: current_user}
  end
end
