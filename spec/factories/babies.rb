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
    name { "MyString" }
    birthday { "2020-03-03" }
    mother_name { "MyString" }
    father_name { "MyString" }
    address { "MyString" }
    phone { "MyString" }
  end
end
