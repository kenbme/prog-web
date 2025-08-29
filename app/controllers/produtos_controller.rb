class ProdutosController < ApplicationController
  def index
    produtos = Produto.all
    render "index", locals: {produtos:}
  end
end
