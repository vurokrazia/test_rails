class CreateActivityLogs < ActiveRecord::Migration[6.0]
  def change
    create_table :activity_logs do |t|
      t.references :baby, null: false, foreign_key: true
      t.references :assistant, null: false, foreign_key: true
      t.references :activity, null: false, foreign_key: true
      t.datetime :start_time
      t.datetime :stop_time
      t.integer :duration
      t.text :comments

      t.timestamps
    end
  end
end
