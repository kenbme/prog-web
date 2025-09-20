class ProdutosController < ApplicationController
  def index
    raise ForbiddenError unless current_user.cliente? || current_user.vendedor?

    usuario = current_user
    produtos = Produto.all.includes(:categoria, :tags, imagens_attachments: :blob)
    produtos = produtos.per_categoria(params[:categoria]) if params[:categoria].present?
    produtos = produtos.per_tags(params[:tags].split(",")) if params[:tags].present?

    render "index", locals: {produtos:, usuario:}
  end

  def new
    raise ForbiddenError unless current_user.vendedor?

    usuario = current_user
    categorias = Categoria.all
    tags = Tag.all
    render "new", locals: {categorias:, tags:, usuario:}
  end

  def create
    raise ForbiddenError unless current_user.vendedor?

    produto = Produto.new(produto_params)

    if params[:new_categoria].present?
      new_categoria = Categoria.find_or_create_by!(nome: params[:new_categoria])
      produto.categoria = new_categoria
    end

    if params[:new_tags].present?
      nomes = params[:new_tags].split(",").map(&:strip)
      new_tags = nomes.map { |nome| Tag.find_or_create_by!(nome:) }
      produto.tags += new_tags
    end

    produto.save!

    render json: {}
  end

  def edit
    raise ForbiddenError unless current_user.vendedor?

    usuario = current_user
    categorias = Categoria.all
    tags = Tag.all
    produto = Produto.find(params[:id])
    render "edit", locals: {categorias:, tags:, produto:, usuario:}
  end

  def update
    raise ForbiddenError unless current_user.vendedor?

    produto = Produto.find(params[:id])
    produto.update!(produto_params)
    render json: {}
  end

  def destroy
    raise ForbiddenError unless current_user.vendedor?

    produto = Produto.find(params[:id])
    produto.destroy!
    render json: {}
  end

  private

  def produto_params
    params.require(:produto).permit(:nome, :descricao, :preco, :estoque, :categoria_id, imagens: [], tag_ids: [])
  end
end
