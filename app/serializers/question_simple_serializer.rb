class QuestionSimpleSerializer < ActiveModel::Serializer
  attributes :id, :body, :response, :value, :question_url

  def question_url
    "#{api_question_url(object.id)}.json"
  end
end
