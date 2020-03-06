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
  attributes :id, :baby_id,:assistant_id, :assistant_name, :activity_id,:start_time, :stop_time
  def assistant_name
    assistant = self.object.assistant
    assistant.name
  end
end
