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

class Token < ApplicationRecord
  belongs_to :user
  validates :user_id, presence:true
  validates :token, presence:true
  validates :expires_at, presence:true
  after_initialize :generate_auth_token
  def is_valid?
    DateTime.now < self.expires_at
  end
  private
  def generate_auth_token
    begin
      self.token = SecureRandom.hex
    end while Token.where(token: self.token).any?
    self.expires_at ||= 1.month.from_now
  end
end
