# == Schema Information
#
# Table name: babies
#
#  id          :bigint           not null, primary key
#  name        :string(255)
#  birthday    :date
#  mother_name :string(255)
#  father_name :string(255)
#  address     :string(255)
#  phone       :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

FactoryBot.define do
  factory :baby do
    name { Faker::Lorem.sentence }
    birthday { Faker::Date.in_date_period   }
    mother_name { Faker::Name.female_first_name } 
    father_name { Faker::Name.male_first_name } 
    address { Faker::Address.street_address }
    phone { Faker::PhoneNumber.phone_number_with_country_code  }
  end
end