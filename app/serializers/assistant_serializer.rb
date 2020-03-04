class AssistantSerializer < ActiveModel::Serializer
  attributes :id, :name, :group,  :address, :phone
end