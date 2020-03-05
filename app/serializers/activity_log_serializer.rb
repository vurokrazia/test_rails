class ActivityLogSerializer < ActiveModel::Serializer
  attributes :id, :baby_id,:assistant_id,:activity_id,:start_time,:stop_time,:duration,:comments
end
