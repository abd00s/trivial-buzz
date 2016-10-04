class QuestionSerializer < ActiveModel::Serializer
  attributes :id, :body, :response, :value, :url

  has_one :category

  def url
    "#{api_question_url(object.id)}.json"
  end
end
