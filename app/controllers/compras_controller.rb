class ComprasController < ApplicationController
  def index
    raise ForbiddenError unless current_user.cliente?

    usuario = current_user
    compras = Compra.includes(itens: :produto).per_usuario(current_user.id)
    render "index", locals: {compras:, usuario:}
  end

  def show
    raise ForbiddenError unless current_user.cliente?

    usuario = current_user
    compra = Compra.includes(itens: :produto).per_usuario(current_user.id).find(params[:id])
    render "show", locals: {compra:, usuario:}
  end

  def create
    raise ForbiddenError unless current_user.cliente?

    carrinho = Carrinho.includes(itens: :produto).per_usuario(current_user.id).first!
    Compras::Create.call(carrinho:)
    render json: {}
  end
end
