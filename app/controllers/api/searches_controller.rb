class Api::SearchesController < ApiController
  def new
    @query_input = params[:query] if params[:query].present?
    @results = Search.new(query: @query_input).results
    @category_results = @results.select{|result| result.class == Category}
    @question_results = @results.select { |result| result.class == Question }
  end
end
