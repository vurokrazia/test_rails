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

class Baby < ApplicationRecord
  validates :name, presence: true
  validates :birthday, presence: true, format: { with: /\A\d+-\d{2}-\d{2}\z/ }
  validates :mother_name, presence: true
  validates :father_name, presence: true
  validates :address, presence: true
  validates :phone, presence: true, length: {minimum: 10}
  has_many :activity_logs
end