usuario = Usuario.find_by!(nome: "João")
carrinho = Carrinho.create!(usuario:)
produto = Produto.first!
produto2 = Produto.second!
CarrinhoItem.create!(produto:, carrinho:, quantidade: 2)
CarrinhoItem.create!(produto: produto2, carrinho:, quantidade: 5)
