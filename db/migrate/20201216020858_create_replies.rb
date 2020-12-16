class CreateReplies < ActiveRecord::Migration[6.0]
  def change
    create_table :replies do |t|
      t.text :description
      t.integer :user_id
      t.integer :comment_id

      t.timestamps
    end
  end
end
