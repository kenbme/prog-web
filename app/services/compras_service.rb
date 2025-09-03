class ComprasService
  def self.create(carrinho:)
    ActiveRecord::Base.transaction do
      compra = Compra.create!(carrinho:, status: :pendente)
      itens_data = carrinho.itens.map do |item|
        {
          compra: compra,
          produto: item.produto,
          quantidade: item.quantidade,
          preco: item.produto.preco
        }
      end
      raise StandardError if itens_data.empty?

      CompraItem.create!(itens_data)

      produtos = carrinho.itens.map do |item|
        item.produto.estoque -= item.quantidade
        item.produto
      end
      Produto.import!(produtos, on_duplicate_key_update: [:estoque])

      carrinho.itens.destroy_all
      compra
    end
  end
end
