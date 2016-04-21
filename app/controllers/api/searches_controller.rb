class Api::SearchesController < ApiController
  def new
    @query_input = params[:query] if params[:query].present?
    @results = Search.new(query: @query_input).results
    @category_results = @results.select{|result| result.class == Category}
    @question_results = @results.select { |result| result.class == Question }
    # render json: @results, each_serializer: ResultsSerializer
    # render json: {type: "#{@results.class}"}
    # respond_with @results
  end

  def set_serializer

  end
end
