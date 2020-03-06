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

class ActivityLog < ApplicationRecord
  include AASM
  before_save :calcule_automatic_minutes
  belongs_to :baby
  belongs_to :assistant
  belongs_to :activity
  validates :status, presence: true, inclusion: {in: ["in_progress", "finished"]}
  validates :baby_id, presence: true
  validates :assistant_id, presence: true
  validates :activity_id, presence: true
  validates :start_time, presence: true, format: { with: /[0-9]{4}-(0[1-9]|1[0-2])-(0[1-9]|[1-2][0-9]|3[0-1]) (2[0-3]|[01][0-9]):[0-5][0-9]:[0-5][0-9]/ }
  validates :stop_time, presence: true, format: { with: /[0-9]{4}-(0[1-9]|1[0-2])-(0[1-9]|[1-2][0-9]|3[0-1]) (2[0-3]|[01][0-9]):[0-5][0-9]:[0-5][0-9]/ }
  validates :duration, presence: true
  validates :comments, presence: true
  validate :datetimes_correct
  def calcule_automatic_minutes
    if !self.start_time.nil? || !self.stop_time.nil?
      self.duration = TimeDifference.between(self.start_time,self.stop_time).in_minutes
    end
  end
  def datetimes_correct
    return if self.stop_time.blank? || self.start_time.blank?
		unless self.start_time <= self.stop_time
			errors.add(:start_time,"The activities cannot beterminated at a time prior to the start date and time")
		end
  end
  aasm(:status) do
    state :in_progress, initial: true
    state :finished
    event :in_progress do
      transitions from: :in_progress, to: :finished
    end
  end
end
