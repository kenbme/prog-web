# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.0].define(version: 2025_09_02_150346) do
  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "admins", force: :cascade do |t|
    t.integer "usuario_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["usuario_id"], name: "index_admins_on_usuario_id", unique: true
  end

  create_table "carrinho_itens", force: :cascade do |t|
    t.integer "carrinho_id", null: false
    t.integer "produto_id", null: false
    t.integer "quantidade", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["carrinho_id", "produto_id"], name: "index_carrinho_itens_on_carrinho_id_and_produto_id", unique: true
    t.index ["carrinho_id"], name: "index_carrinho_itens_on_carrinho_id"
    t.index ["produto_id"], name: "index_carrinho_itens_on_produto_id"
  end

  create_table "carrinhos", force: :cascade do |t|
    t.integer "cliente_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cliente_id"], name: "index_carrinhos_on_cliente_id", unique: true
  end

  create_table "categorias", force: :cascade do |t|
    t.string "nome", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["nome"], name: "index_categorias_on_nome", unique: true
  end

  create_table "clientes", force: :cascade do |t|
    t.integer "usuario_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["usuario_id"], name: "index_clientes_on_usuario_id", unique: true
  end

  create_table "compra_itens", force: :cascade do |t|
    t.integer "compra_id", null: false
    t.integer "produto_id", null: false
    t.integer "quantidade", null: false
    t.integer "preco", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["compra_id"], name: "index_compra_itens_on_compra_id"
    t.index ["produto_id"], name: "index_compra_itens_on_produto_id"
  end

  create_table "compras", force: :cascade do |t|
    t.integer "carrinho_id", null: false
    t.integer "status", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["carrinho_id"], name: "index_compras_on_carrinho_id"
  end

  create_table "produtos", force: :cascade do |t|
    t.string "nome", null: false
    t.string "descricao", null: false
    t.integer "preco", null: false
    t.integer "estoque", null: false
    t.integer "categoria_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["categoria_id"], name: "index_produtos_on_categoria_id"
  end

  create_table "taggings", force: :cascade do |t|
    t.integer "tag_id", null: false
    t.integer "produto_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["produto_id"], name: "index_taggings_on_produto_id"
    t.index ["tag_id", "produto_id"], name: "index_taggings_on_tag_id_and_produto_id", unique: true
    t.index ["tag_id"], name: "index_taggings_on_tag_id"
  end

  create_table "tags", force: :cascade do |t|
    t.string "nome", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["nome"], name: "index_tags_on_nome", unique: true
  end

  create_table "usuarios", force: :cascade do |t|
    t.string "nome", null: false
    t.integer "cargo", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["nome"], name: "index_usuarios_on_nome", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "admins", "usuarios"
  add_foreign_key "carrinho_itens", "carrinhos"
  add_foreign_key "carrinho_itens", "produtos"
  add_foreign_key "carrinhos", "clientes"
  add_foreign_key "clientes", "usuarios"
  add_foreign_key "compra_itens", "compras"
  add_foreign_key "compra_itens", "produtos"
  add_foreign_key "compras", "carrinhos"
  add_foreign_key "produtos", "categorias"
  add_foreign_key "taggings", "produtos"
  add_foreign_key "taggings", "tags"
end
