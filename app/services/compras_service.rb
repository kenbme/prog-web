class ComprasService
  class << self
    def create(carrinho:)
      raise EmptyCarrinhoError if carrinho.itens.empty?

      ActiveRecord::Base.transaction do
        compra = Compra.create!(carrinho:, status: :pendente)
        create_compra_itens!(compra:, itens: carrinho.itens)
        decrement_estoque!(carrinho:)
        carrinho.itens.destroy_all
        compra
      end
    end

    private

    def create_compra_itens!(compra:, itens:)
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

    def decrement_estoque!(carrinho:)
      sql = <<~SQL.squish
        UPDATE produtos
        SET estoque = produtos.estoque - carrinho_itens.quantidade
        FROM carrinho_itens
        WHERE carrinho_itens.carrinho_id = $1
          AND carrinho_itens.produto_id = produtos.id
          AND produtos.estoque >= carrinho_itens.quantidade
      SQL

      rows = ActiveRecord::Base.connection.exec_update(sql, "decrement_estoque!", [carrinho.id])
      raise InsufficientEstoqueError if rows != carrinho.itens.count
    end
  end
end
