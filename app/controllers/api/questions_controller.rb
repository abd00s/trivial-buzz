class Api::QuestionsController < ApiController
  def show
    @question = Question.find(params[:id])
    respond_with @question, serializer: QuestionOnlySerializer, root: :question
  end

  def random
    # Returns a random question, asked between two dates, if provided.
    # Example usage:
    # ../questions/random.json?newer_than=2009-03-02&older_than=2010-02-03
    # Optional parameters `newer_than` and `older_than` define bounds if present
    # Query string may include an upper and/or a lower bound or none.

    if params[:newer_than].present?
      minimum =
        begin
          Date.parse(params[:newer_than])
        rescue ArgumentError, TypeError
          render json: {Error: "Invalid lower bound, format should be YYYY-DD-MM"} and return
        end
    end

    if params[:older_than].present?
      maximum =
        begin
          Date.parse(params[:older_than])
        rescue ArgumentError, TypeError
          render json: {Error: "Invalid upper bound, format should be YYYY-DD-MM"} and return
        end
    end

    if minimum.present? && maximum.present? && minimum > maximum
      render json: {Error: "Invalid range; minimum is greater than maximum."} and return
    end

    # We make use of chaining scopes defined on Question.
    @question = Question.newer_than(minimum)
      .older_than(maximum)
      .random

    if @question.present?
      respond_with @question, serializer: QuestionOnlySerializer, root: :question
    else
      oldest = Show.order(:air_date).first.air_date
      newest = Show.order(air_date: :desc).first.air_date
      render json: {Error: "No questions in selected range; no shows aired in range or bounds are outside of valid range #{oldest} to #{newest}"}
    end
  end
end
