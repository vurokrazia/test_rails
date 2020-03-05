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
    # it "raises an error if end time is lower than start time" do
    #   #let(:activity_log) { create(:activity_log_error_datetimes )}
    #   activity_log = FactoryBot.create(:activity_log_error_datetimes)
    #   #city.errors(:base).should eq ["already exists"]
    #   activity_log.valid?
    #   activity_log.errors.full_messages.should include("The activities cannot beterminated at a time prior to the start date and time")
    # end
    # context "when an admin" do
    #   subject { User.new(admin: true) }
  
    #   it { should validate_presence_of(:role) }
    # end
  end
end