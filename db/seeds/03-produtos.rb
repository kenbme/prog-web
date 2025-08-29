categoria = Categoria.find_by!(nome: "Bolsas")
categoria2 = Categoria.find_by!(nome: "Sapatos")

tag = Tag.find_by!(nome: "Promoção")
tag2 = Tag.find_by!(nome: "Novo")

produto = Produto.create!({categoria:, nome: "Bolsa Bonita", descricao: "Uma bolsa bonita!", preco: 200000 * 100, estoque: 10})
produto2 = Produto.create!({categoria:, nome: "Bolsa Bonita 2", descricao: "Uma bolsa bonita!", preco: 300000000 * 100, estoque: 20})
produto3 = Produto.create!({categoria: categoria2, nome: "Sapato Legal", descricao: "Um sapato legal!", preco: 400 * 100, estoque: 30})

produto.imagens.attach(
  File.open(Rails.root.join("db/seeds/images/bolsa.webp"))
)

produto2.tags << tag

produto3.imagens.attach(
  File.open(Rails.root.join("db/seeds/images/sapato.webp"))
)
produto3.imagens.attach(
  File.open(Rails.root.join("db/seeds/images/sapato.webp"))
)

produto3.tags << [tag, tag2]
