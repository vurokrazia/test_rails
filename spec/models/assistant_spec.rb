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
#

require 'rails_helper'

RSpec.describe Assistant, type: :model do
  describe "validations in Assistant" do 
    it "validate presence of required fields" do
      should validate_presence_of(:name)
      should validate_presence_of(:group)
      should validate_presence_of(:address)
      should validate_presence_of(:phone)
    end
  end
end
