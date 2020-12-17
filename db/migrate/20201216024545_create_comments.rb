class CreateComments < ActiveRecord::Migration[6.0]
  def change
    create_table :comments do |t|
      t.text :description
      t.integer :post_id
      t.integer :user_id

      t.timestamps
    end
  end
end
