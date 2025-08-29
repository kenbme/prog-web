usuario = Usuario.find_by!(nome: "João")
carrinho = Carrinho.create!(usuario:)
produto = Produto.first!
CarrinhoItem.create!(produto:, carrinho:, quantidade: 1)
