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

require 'rails_helper'

RSpec.describe Token, type: :model do
  describe "validations in Token" do 
    it "validate presence of required fields" do
      should validate_presence_of(:user_id)
      should validate_presence_of(:token)
      should validate_presence_of(:expires_at)
    end
  end
end
