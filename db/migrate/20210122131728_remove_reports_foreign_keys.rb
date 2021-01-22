class RemoveReportsForeignKeys < ActiveRecord::Migration[6.0]
  def change
    remove_foreign_key :reports, column: :reply_id
  end
end
