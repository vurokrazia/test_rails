# == Schema Information
#
# Table name: assistants
#
#  id         :bigint           not null, primary key
#  name       :string(255)
#  group      :string(255)
#  address    :string(255)
#  phone      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint
#

FactoryBot.define do
  factory :assistant do
    name { Faker::Lorem.sentence }
    group { Faker::Educator.course_name }
    address { Faker::Address.street_address }
    phone { Faker::PhoneNumber.phone_number_with_country_code }
    user
  end
end
