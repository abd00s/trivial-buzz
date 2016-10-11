class Api::QuestionsController < ApiController
  def show
    @question =
      begin
        Question.find(question_params[:id])
      rescue ActiveRecord::RecordNotFound
        display_error(404, "There is no question with ID #{question_params[:id]}") and return
      end
    respond_with @question, serializer: QuestionOnlySerializer, root: :question
  end

  def index
    # Date range limiters
    if params[:newer_than].present?
      minimum =
        begin
          Date.parse(params[:newer_than])
        rescue ArgumentError, TypeError
          display_error(400, "Invalid lower bound, newer_than format should be YYYY-MM-DD") and return
        end
    end

    if params[:older_than].present?
      maximum =
        begin
          Date.parse(params[:older_than])
        rescue ArgumentError, TypeError
          display_error(400, "Invalid upper bound, older_than format should be YYYY-MM-DD") and return
        end
    end

    if minimum.present? && maximum.present? && minimum > maximum
      display_error(400, "Invalid range; minimum is greater than maximum.") and return
    end

    # Value range limiters
    lower_bound = params[:value_greater] if params[:value_greater].present?
    upper_bound = params[:value_less] if params[:value_less].present?
    value = params[:value_equals] if params[:value_equals].present?

    if lower_bound.present? && upper_bound.present? && lower_bound.to_i > upper_bound.to_i
      display_error(400, "Invalid range; minimum value is greater than maximum value.") and return
    end

    if value.present?
      if lower_bound.present? || upper_bound.present?
        display_error(400, "Invalid params; [:value] defines exact question value and "\
        + "may not be used with [:value_greater] or [:value_less]") and return
      end
    end

    @questions = Question.joins(round: :show)
      .order("shows.air_date")
      .order(:value)
      .newer_than(minimum)
      .older_than(maximum)
      .value_greater(lower_bound)
      .value_less(upper_bound)
      .value_equals(value)
      .page(params[:page])
      .per(100)

    if @questions.present?
      respond_with @questions, each_serializer: QuestionSerializer, meta: pagination_dict(@questions)
    else
      oldest = Show.order(:air_date).first.air_date
      newest = Show.order(air_date: :desc).first.air_date
      display_error(404, "No questions in selected range; no shows aired in range or " \
        + "bounds are outside of valid range #{oldest} to #{newest}; if an exact value " \
        + "or range were passed, no questions with such value were found.") and return
    end
  end

  def random
    # Returns a random question, asked between two dates, if provided.
    # Example usage:
    # ../questions/random.json?newer_than=2009-03-02&older_than=2010-02-03
    # Optional parameters `newer_than` and `older_than` define bounds if present
    # Query string may include an upper and/or a lower bound or none.

    # Date range limiters
    if params[:newer_than].present?
      minimum =
        begin
          Date.parse(params[:newer_than])
        rescue ArgumentError, TypeError
          display_error(400, "Invalid lower bound, newer_than format should be YYYY-MM-DD") and return
        end
    end

    if params[:older_than].present?
      maximum =
        begin
          Date.parse(params[:older_than])
        rescue ArgumentError, TypeError
          display_error(400, "Invalid upper bound, older_than format should be YYYY-MM-DD") and return
        end
    end

    if minimum.present? && maximum.present? && minimum > maximum
      display_error(400, "Invalid range; minimum is greater than maximum.") and return
    end

    # Value range limiters
    lower_bound = params[:value_greater] if params[:value_greater].present?
    upper_bound = params[:value_less] if params[:value_less].present?
    value = params[:value_equals] if params[:value_equals].present?

    if lower_bound.present? && upper_bound.present? && lower_bound.to_i > upper_bound.to_i
      display_error(400, "Invalid range; minimum value is greater than maximum value.") and return
    end

    if value.present?
      if lower_bound.present? || upper_bound.present?
        display_error(400, "Invalid params; [:value] defines exact question value and "\
        + "may not be used with [:value_greater] or [:value_less]") and return
      end
    end

    # We make use of chaining scopes defined on Question.
    @question = Question.includes(round: :show)
      .newer_than(minimum)
      .older_than(maximum)
      .value_greater(lower_bound)
      .value_less(upper_bound)
      .value_equals(value)
      .random

    if @question.present?
      respond_with @question, serializer: QuestionOnlySerializer, root: :question
    else
      oldest = Show.order(:air_date).first.air_date
      newest = Show.order(air_date: :desc).first.air_date
      display_error(404, "No questions in selected range; no shows aired in range or " \
        + "bounds are outside of valid range #{oldest} to #{newest}; if an exact value " \
        + "or range were passed, no questions with such value were found.") and return
    end
  end

  private
  def question_params
    params.permit(:id)
  end
end
