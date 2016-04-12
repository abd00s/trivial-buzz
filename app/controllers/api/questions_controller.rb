class Api::QuestionsController < ApiController
  def show
    @question = Question.find(params[:id])
    respond_with @question, serializer: QuestionOnlySerializer, root: :question
  end

  def random
    record_id = rand(Question.count)
    @question = Question.find(record_id)
    respond_with @question, serializer: QuestionOnlySerializer, root: :question
  end
end
