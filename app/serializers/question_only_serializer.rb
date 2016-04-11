class QuestionOnlySerializer < ActiveModel::Serializer
  attributes :id, :body, :response, :value

  has_one :category

  has_one :round, serializer: RoundOnlySerializer, root: :from_round
end
