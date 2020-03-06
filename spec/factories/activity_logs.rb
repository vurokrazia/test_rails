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

FactoryBot.define do
  factory :activity_log do
    start_time { Faker::Date.forward(days: 1) }
    stop_time { Faker::Date.forward(days: 5) }
    duration { Faker::Number.between(from: 1, to: 10) }
    comments { Faker::Lorem.sentence }
    baby
    assistant
    activity
  end
  factory :activity_log_error_datetime, class: 'ActivityLog' do
    start_time { Faker::Date.forward(days: 2) }
    stop_time { Faker::Date.forward(days: 1) }
    duration { Faker::Number.between(from: 1, to: 10) }
    comments { Faker::Lorem.sentence }
    baby
    assistant
    activity
  end
end
