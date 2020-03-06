# == Schema Information
#
# Table name: tokens
#
#  id         :bigint           not null, primary key
#  expires_at :string(255)
#  token      :string(255)
#  user_id    :bigint           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryBot.define do
  factory :token do
    expires_at { Faker::Date.in_date_period }
    token { SecureRandom.hex }
    user
  end
end
