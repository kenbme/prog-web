cliente = Cliente.first!
carrinho = Carrinho.create!(cliente:)
produto = Produto.first!
produto2 = Produto.second!
CarrinhoItem.create!(produto:, carrinho:, quantidade: 4)
CarrinhoItem.create!(produto: produto2, carrinho:, quantidade: 5)
