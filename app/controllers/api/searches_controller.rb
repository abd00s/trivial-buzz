class Api::SearchesController < ApiController
  def new
    @query_input = params[:query] if params[:query].present?
    @search_results = Search.new(query: @query_input).results
    # Paginate array as @search_results is not an AR collection
    @paginated_results = Kaminari.paginate_array(@search_results.select do |result|
      if params[:only]
        # Only display results that are: `Question`'s or `Category`'s
        if ["Question","Category"].include?(params[:only].capitalize)
          result.class.to_s == params[:only].capitalize
        else
          # Render error if param in not either of Question or Category
          display_error(400, "#{params[:only]} is not a valid filter. " \
            + "Valid filters are Question and Category.") and return
        end
      else
        # Display all if no [:only] param is passed
        true
      end
    end
    )
    .page(params[:page])
    .per(50)

    @category_results_count = @search_results.select{|result| result.class == Category}.count
    @question_results_count = @search_results.select { |result| result.class == Question }.count
  end
end
