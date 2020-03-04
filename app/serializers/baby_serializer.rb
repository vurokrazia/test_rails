class BabySerializer < ActiveModel::Serializer
  attributes :id, :name, :birthday, :mother_name, :father_name, :address, :phone
end
