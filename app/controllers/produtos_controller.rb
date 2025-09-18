class ProdutosController < ApplicationController
  def index
    raise ForbiddenError unless current_user.cliente? || current_user.vendedor?

    produtos = Produto.all.includes(:categoria, :tags, imagens_attachments: :blob)
    produtos = produtos.per_categoria(params[:categoria]) if params[:categoria].present?
    produtos = produtos.per_tags(params[:tags].split(",")) if params[:tags].present?

    render "index", locals: {produtos:}, status: :ok
  end

  def new
    raise ForbiddenError unless current_user.vendedor?

    categorias = Categoria.all
    tags = Tag.all
    render "new", locals: {categorias:, tags:}, status: :ok
  end

  def create
    raise ForbiddenError unless current_user.vendedor?

    Produto.create!(produto_params)
    redirect_to :produtos, alert: "Produto criado!"
  end

  def edit
    raise ForbiddenError unless current_user.vendedor?

    categorias = Categoria.all
    tags = Tag.all
    produto = Produto.find(params[:id])
    render "edit", locals: {categorias:, tags:, produto:}, status: :ok
  end

  def update
    raise ForbiddenError unless current_user.vendedor?

    produto = Produto.find(params[:id])
    produto.update!(produto_params)
    redirect_to :produtos, alert: "Produto atualizado!"
  end

  def destroy
    raise ForbiddenError unless current_user.vendedor?

    produto = Produto.find(params[:id])
    produto.destroy!
    redirect_to :produtos, alert: "Produto deletado!"
  end

  private

  def produto_params
    params.require(:produto).permit(:nome, :descricao, :preco, :estoque, :categoria_id, imagens: [], tag_ids: [])
  end
end
