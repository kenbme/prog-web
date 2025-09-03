class ComprasService
  def self.create(carrinho:)
    raise EmptyCarrinhoError if carrinho.itens.empty?

    ActiveRecord::Base.transaction do
      compra = Compra.create!(carrinho:, status: :pendente)
      create_compra_itens!(compra:, itens: carrinho.itens)
      decrement_estoque!(carrinho:)
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

  def self.decrement_estoque!(carrinho:)
    ActiveRecord::Base.transaction do
      sql = <<~SQL
        UPDATE produtos
        SET estoque = estoque - (
          SELECT quantidade
          FROM carrinho_itens
          WHERE carrinho_itens.produto_id = produtos.id
            AND carrinho_itens.carrinho_id = #{carrinho.id}
        )
        WHERE id IN (
          SELECT produto_id
          FROM carrinho_itens
          WHERE carrinho_id = #{carrinho.id}
            AND estoque >= quantidade
        )
      SQL

      rows = ActiveRecord::Base.connection.update(sql)
      raise InsufficientEstoqueError if rows != carrinho.itens.count
    end
  end
end
