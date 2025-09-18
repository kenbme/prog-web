class ProdutosController < ApplicationController
  def index
    raise ForbiddenError unless current_user.cliente? || current_user.vendedor?

    usuario = current_user
    produtos = Produto.all.includes(:categoria, :tags, imagens_attachments: :blob)
    produtos = produtos.per_categoria(params[:categoria]) if params[:categoria].present?
    produtos = produtos.per_tags(params[:tags].split(",")) if params[:tags].present?

    render "index", locals: {produtos:, usuario:}, status: :ok
  end

  def new
    raise ForbiddenError unless current_user.vendedor?

    usuario = current_user
    categorias = Categoria.all
    tags = Tag.all
    render "new", locals: {categorias:, tags:, usuario:}, status: :ok
  end

  def create
    raise ForbiddenError unless current_user.vendedor?

    Produto.create!(produto_params)
    render json: {}, status: :ok
  end

  def edit
    raise ForbiddenError unless current_user.vendedor?

    usuario = current_user
    categorias = Categoria.all
    tags = Tag.all
    produto = Produto.find(params[:id])
    render "edit", locals: {categorias:, tags:, produto:, usuario:}, status: :ok
  end

  def update
    raise ForbiddenError unless current_user.vendedor?

    produto = Produto.find(params[:id])
    produto.update!(produto_params)
    render json: {}, status: :ok
  end

  def destroy
    raise ForbiddenError unless current_user.vendedor?

    produto = Produto.find(params[:id])
    produto.destroy!
    render json: {}, status: :ok
  end

  private

  def produto_params
    params.require(:produto).permit(:nome, :descricao, :preco, :estoque, :categoria_id, imagens: [], tag_ids: [])
  end
end
