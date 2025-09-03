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
    ActiveRecord::Base.transaction do
      ids = itens.map(&:produto_id)
      itens.map(&:quantidade)

      cases_sql = itens.map { |item| "WHEN id = #{item.produto_id} THEN estoque - #{item.quantidade}" }.join(" ")
      conditions_sql = itens.map { |item| "(id = #{item.produto_id} AND estoque >= #{item.quantidade})" }.join(" OR ")

      sql = <<~SQL
        UPDATE produtos
        SET estoque = CASE #{cases_sql} END
        WHERE id IN (#{ids.join(",")})
          AND (#{conditions_sql})
      SQL

      rows = ActiveRecord::Base.connection.update(sql)

      raise "Estoque insuficiente para algum produto" if rows != itens.size
    end
  end
end
