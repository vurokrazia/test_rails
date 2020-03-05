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

require 'rails_helper'

RSpec.describe ActivityLog, type: :model do
  describe "validations" do
    it "validate presence of of required fields" do
      should validate_presence_of(:start_time)
      should validate_presence_of(:stop_time)
      should validate_presence_of(:duration)
      should validate_presence_of(:comments)
      should validate_presence_of(:baby_id)
      should validate_presence_of(:assistant_id)
      should validate_presence_of(:activity_id)
    end
  end
end