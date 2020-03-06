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

class BabySerializer < ActiveModel::Serializer
  attributes :id, :name, :birthday, :mother_name, :father_name, :address, :phone
end
