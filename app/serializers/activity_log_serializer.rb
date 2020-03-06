# == Schema Information
#
# Table name: activity_logs
#
#  id           :bigint           not null, primary key
#  baby_id      :bigint           not null
#  assistant_id :bigint           not null
#  activity_id  :bigint           not null
#  start_time   :datetime
#  stop_time    :datetime
#  duration     :integer
#  comments     :text(65535)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  status       :string(255)      default("in_progress")
#

class ActivityLogSerializer < ActiveModel::Serializer
  attributes :id, :baby_id, :baby_name, :assistant_id, :assistant_name, :status, :activity_id, :activity_name, :start_time, :stop_time, :duration
  def baby_name
    baby = self.object.baby
    baby.name
  end
  def assistant_name
    assistant = self.object.assistant
    assistant.name
  end
  def activity_name
    activity = self.object.activity
    activity.name
  end
end
