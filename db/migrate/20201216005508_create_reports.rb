class CreateReports < ActiveRecord::Migration[6.0]
  def change
    create_table :reports do |t|
      t.integer :reply_id
      t.integer :comment_id

      t.timestamps
    end
  end
end
