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

class AssistantSerializer < ActiveModel::Serializer
  attributes :id, :name, :group,  :address, :phone
end
