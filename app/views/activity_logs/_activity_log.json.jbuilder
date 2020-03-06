json.extract! activity_log, :id, :baby_id, :assistant_id, :activity_id, :start_time, :stop_time, :duration, :comments, :created_at, :updated_at
json.url activity_log_url(activity_log, format: :json)
