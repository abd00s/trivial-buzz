class RoundSerializer < ActiveModel::Serializer
  attributes :id, :name

  has_one :show, serializer: ShowSimpleSerializer, root: :from_show

  has_many :questions
end
