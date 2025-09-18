class CarrinhoController < ApplicationController
  def index
    raise ForbiddenError unless current_user.cliente?

    usuario = current_user
    carrinho = Carrinho.per_usuario(current_user.id).includes(produtos: [:categoria, :tags, imagens_attachments: :blob]).first!
    render "index", locals: {carrinho:, usuario:}, status: :ok
  end

  def add_to_carrinho
    raise ForbiddenError unless current_user.cliente?

    carrinho = Carrinho.per_usuario(current_user.id).first!
    item = CarrinhoItem.find_or_initialize_by(carrinho:, produto_id: params[:produto_id])
    item.quantidade ||= 0
    item.quantidade += params[:quantidade].to_i
    item.save!
    render json: {}, status: :ok
  end

  def clean_carrinho
    raise ForbiddenError unless current_user.cliente?

    carrinho = Carrinho.per_usuario(current_user.id).first!
    carrinho.itens.destroy_all
    render json: {}, status: :ok
  end
end
