# == Schema Information
#
# Table name: activities
#
#  id          :bigint           not null, primary key
#  name        :string(255)
#  description :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
require 'faker'
FactoryBot.define do
  factory :activity do
    name { Faker::Lorem.sentence }
    description { Faker::Lorem.paragraph }
  end
end