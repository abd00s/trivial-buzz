class Api::QuestionsController < ApiController
  def show
    @question = Question.find(params[:id])
    respond_with @question, serializer: QuestionOnlySerializer, root: :question
  end
end
