class Api::SearchesController < ApiController
  def new
    @query_input = params[:query] if params[:query].present?
    @results = Kaminari.paginate_array(Search.new(query: @query_input).results).page(params[:page]).per(50)
    @category_results_count = @results.select{|result| result.class == Category}.count
    @question_results_count = @results.select { |result| result.class == Question }.count
  end
end
