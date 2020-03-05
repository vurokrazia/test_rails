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
#

class ActivityLog < ApplicationRecord
  belongs_to :baby
  belongs_to :assistant
  belongs_to :activity
  validates :baby_id, presence: true
  validates :assistant_id, presence: true
  validates :activity_id, presence: true
  validates :start_time, presence: true
  validates :stop_time, presence: true
  validates :duration, presence: true
  validates :comments, presence: true
  validate :datetimes_correct, if: -> { !self.start_time.nil? && !self.stop_time.nil? }
  def datetimes_correct
		unless self.start_time <= self.stop_time
			errors.add(:start_time,"The activities cannot beterminated at a time prior to the start date and time")
		end
	end
end
