class ActivitySerializer < ActiveModel::Serializer
  attribute :id, :name, :description
end
