class CategoryDetailSerializer < ActiveModel::Serializer
  attributes :id, :name, :questions_count

  has_many :shows, serializer: ShowSimpleSerializer

  has_many :questions, serializer: QuestionSimpleSerializer

end