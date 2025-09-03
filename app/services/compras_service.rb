class ComprasService
  def self.create(carrinho:)
    raise EmptyCarrinhoError if carrinho.itens.empty?

    ActiveRecord::Base.transaction do
      compra = Compra.create!(carrinho:, status: :pendente)
      create_compra_itens!(compra:, itens: carrinho.itens)
      decrement_estoque!(itens: carrinho.itens)
      carrinho.itens.destroy_all
      compra
    end
  end

  def self.create_compra_itens!(compra:, itens:)
    itens_data = itens.map do |item|
      {
        compra: compra,
        produto: item.produto,
        quantidade: item.quantidade,
        preco: item.produto.preco
      }
    end
    CompraItem.create!(itens_data)
  end

  def self.decrement_estoque!(itens:)
    produtos = itens.map do |item|
      item.produto.estoque -= item.quantidade
      item.produto
    end
    Produto.import!(produtos, on_duplicate_key_update: [:estoque])
  end
end
