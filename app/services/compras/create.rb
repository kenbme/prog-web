class Compras::Create
  class << self
    def call(carrinho:)
      raise EmptyCarrinhoError if carrinho.itens.empty?

      ActiveRecord::Base.transaction do
        compra = Compra.create!(carrinho:, status: :pendente)
        create_compra_itens!(compra:, itens: carrinho.itens)
        decrement_estoque!(carrinho:)
        carrinho.itens.delete_all
        compra
      end
    end

    private

    def create_compra_itens!(compra:, itens:)
      itens_data = itens.map do |item|
        attrs = {
          compra_id: compra.id,
          produto_id: item.produto.id,
          quantidade: item.quantidade,
          preco: item.produto.preco
        }
        validate_fields!(CompraItem.new(attrs), [:quantidade, :preco])
        attrs
      end
      CompraItem.insert_all!(itens_data)
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

    def validate_fields!(record, attrs)
      attrs.each do |attr|
        record.class.validators_on(attr).each do |validator|
          validator.validate_each(record, attr, record.send(attr))
        end
      end

      raise ActiveRecord::RecordInvalid.new(record) if record.errors.any?
    end
  end
end
