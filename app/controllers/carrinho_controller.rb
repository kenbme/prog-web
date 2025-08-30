class CarrinhoController < ApplicationController
  def index
    raise ForbiddenError unless current_user.cliente?

    carrinho = Carrinho.find_by!(usuario: current_user)
    render "index", locals: {carrinho:}
  end

  def add_to_carrinho
    raise ForbiddenError unless current_user.cliente?

    carrinho = Carrinho.find_by!(usuario: current_user)
    item = CarrinhoItem.find_or_initialize_by(carrinho:, produto_id: params[:produto_id])
    item.quantidade ||= 0
    item.quantidade += params[:quantidade].to_i
    item.save!
    render json: {}, status: :ok
  end

  def clean_carrinho
    raise ForbiddenError unless current_user.cliente?

    carrinho = Carrinho.find_by!(usuario: current_user)
    carrinho.itens.destroy_all
    render json: {}, status: :ok
  end
end
