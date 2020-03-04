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

require 'rails_helper'

RSpec.describe Activity, type: :model do
  describe "validations in Activity" do 
    it "validate presence of required fields" do
      should validate_presence_of(:name)
      should validate_presence_of(:description)
    end
  end
end
