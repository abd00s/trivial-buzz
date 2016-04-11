class QuestionOnlySerializer < ActiveModel::Serializer
  attributes :id, :body, :response, :value

  has_one :category#, serializer:

end
