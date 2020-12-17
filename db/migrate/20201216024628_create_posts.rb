class CreatePosts < ActiveRecord::Migration[6.0]
  def change
    create_table :posts do |t|
      t.string :name
      t.text :content
      t.string :image_url
      t.integer :views

      t.timestamps
    end
  end
end
