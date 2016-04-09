class Api::QuestionsController < ApiController
  def show
    @question = Question.find(params[:id])
    respond_with @question, serializer: QuestionSerializer
  end
end
