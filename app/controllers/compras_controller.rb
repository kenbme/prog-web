class ComprasController < ApplicationController
  def index
    raise ForbiddenError unless current_user.cliente?

    compras = Compra.per_usuario(current_user.id)
    render "index", locals: {compras:}, status: :ok
  end

  def show
    raise ForbiddenError unless current_user.cliente?

    compra = Compra.per_usuario(current_user.id).find(params[:id])
    render "show", locals: {compra:}, status: :ok
  end

  def create
    raise ForbiddenError unless current_user.cliente?

    ComprasService.create(current_user.id)
    render json: {}, status: :ok
  end
end
