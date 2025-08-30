class ProdutosController < ApplicationController
  def index
    raise ForbiddenError unless current_user.cliente?

    produtos = Produto.all
    produtos = produtos.per_categoria(categoria: params[:categoria]) if params[:categoria].present?
    produtos = produtos.per_tags(categoria: tags.split(",")) if params[:tags].present?

    render "index", locals: {produtos:}
  end
end
