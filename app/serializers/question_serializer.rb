class QuestionSerializer < ActiveModel::Serializer
  attributes :id, :body, :response, :value, :question_url

  has_one :category

  def question_url
    "#{api_question_url(object.id)}.json"
  end
end
