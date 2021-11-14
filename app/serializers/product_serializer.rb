class ProductSerializer < ActiveModel::Serializer
  attributes :id, :name, :status, :description, :created_at

  belongs_to :category
end
