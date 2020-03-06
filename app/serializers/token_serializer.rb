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

class TokenSerializer < ActiveModel::Serializer
  attributes :id, :expires_at, :token
end
