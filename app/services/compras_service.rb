class ComprasService
  def self.create(usuario_id)
    ActiveRecord::Base.transaction do
      carrinho = Carrinho.per_usuario(usuario_id).first!
      compra = Compra.create!(carrinho:, status: :pendente)
      carrinho.itens.each do |item|
        CompraItem.create!(
          compra: compra,
          produto: item.produto,
          quantidade: item.quantidade,
          preco: item.produto.preco
        )
        item.produto.decrement!(:estoque, item.quantidade)
      end
      carrinho.itens.destroy_all
      compra
    end
  end
end
