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

require 'rails_helper'

RSpec.describe Baby, type: :model do
  describe "validations in Baby" do 
    it "validate presence of required fields" do
      should validate_presence_of(:name)
      should validate_presence_of(:birthday)
      should validate_presence_of(:mother_name)
      should validate_presence_of(:father_name)
      should validate_presence_of(:address)
      should validate_presence_of(:phone)
    end
    it "validate minimum length" do
      should validate_length_of(:phone).is_at_least(10)
    end
  end
end
