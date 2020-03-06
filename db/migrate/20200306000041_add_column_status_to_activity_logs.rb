class AddColumnStatusToActivityLogs < ActiveRecord::Migration[6.0]
  def change
    add_column :activity_logs, :status, :string, default: "in_progress"
  end
end 
