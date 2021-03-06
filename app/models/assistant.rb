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

class Assistant < ApplicationRecord
  belongs_to :user, optional: true
  validates :name, presence: true
  validates :group, presence: true
  validates :address, presence: true
  validates :phone, presence: true, length: {minimum: 10}
  has_many :activity_logs
  scope :order_name_asc, -> {order(name: :ASC)}
end
