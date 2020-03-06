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

class Activity < ApplicationRecord
  validates :name, presence: true
  validates :description, presence: true
  has_many :activity_logs
  scope :order_name_asc, -> {order(name: :ASC)}
end
