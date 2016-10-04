class QuestionSimpleSerializer < ActiveModel::Serializer
  attributes :id, :body, :response, :value, :url

  def url
    "#{api_question_url(object.id)}.json"
  end
end
