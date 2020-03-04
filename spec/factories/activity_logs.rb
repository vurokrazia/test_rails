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

FactoryBot.define do
  factory :activity_log do
    baby { nil }
    assistant { nil }
    activity { nil }
    start_time { "2020-03-04 00:00:15" }
    stop_time { "2020-03-04 00:00:15" }
    duration { 1 }
    comments { "MyText" }
  end
end
