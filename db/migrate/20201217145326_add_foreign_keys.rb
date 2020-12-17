class AddForeignKeys < ActiveRecord::Migration[6.0]
  def change
    
    # Adicionando foreign keys as colunas já existentes das tabelas

    # comments
    add_foreign_key "comments", "users", column: "user_id"
    add_foreign_key "comments", "posts", column: "post_id"

    # likes
    add_foreign_key "likes", "users", column: "user_id"
    add_foreign_key "likes", "posts", column: "post_id"

    # replies
    add_foreign_key "replies", "users", column: "user_id"
    add_foreign_key "replies", "comments", column: "comment_id"

    # reports
    add_foreign_key "reports", "replies", column: "reply_id"
    add_foreign_key "reports", "comments", column: "comment_id"

    # tag_posts
    add_foreign_key "tag_posts", "posts", column: "post_id"
    add_foreign_key "tag_posts", "tags", column: "tag_id"
  end
end
