class AddForeignKeys < ActiveRecord::Migration[6.0]
  def change
    
    # Adicionando foreign keys as colunas já existentes das tabelas

    # comments
    add_foreign_key "comments", "users", column: "user_id", on_delete: :cascade
    add_foreign_key "comments", "posts", column: "post_id", on_delete: :cascade

    # likes
    add_foreign_key "likes", "users", column: "user_id", on_delete: :cascade
    add_foreign_key "likes", "posts", column: "post_id", on_delete: :cascade

    # replies
    add_foreign_key "replies", "users", column: "user_id", on_delete: :cascade
    add_foreign_key "replies", "comments", column: "comment_id", on_delete: :cascade

    # reports
    add_foreign_key "reports", "replies", column: "reply_id", on_delete: :cascade
    add_foreign_key "reports", "comments", column: "comment_id", on_delete: :cascade

    # tag_posts
    add_foreign_key "tag_posts", "posts", column: "post_id", on_delete: :cascade
    add_foreign_key "tag_posts", "tags", column: "tag_id", on_delete: :cascade
  end
end
