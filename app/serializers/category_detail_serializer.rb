class CategoryDetailSerializer < ActiveModel::Serializer
  attributes :id, :name, :questions_count

  has_many :questions, serializer: QuestionSimpleSerializer
end
