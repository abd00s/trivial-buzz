class Api::SearchesController < ApiController
  def new
    @query_input = params[:query] if params[:query].present?
    @results = Kaminari.paginate_array(                 # Paginate array as search is not an AR collection
                Search.new(query: @query_input).results
                  .select do |result|

                    if params[:only]                                                # Only display results that are:
                                                                                    # `Question`'s or `Category`'s
                      if ["Question","Category"].include?(params[:only].capitalize)
                        result.class.to_s == params[:only].capitalize
                      else
                        display_error(400, "#{params[:only]} is not a valid filter. \
                          Valid filters are Question and Category.") and return
                      end                                                             # Render error if param in not
                                                                                      # either of Question or Category
                    else
                      true                                            # Display all if no [:only] param is passed
                    end

                  end
                )
                .page(params[:page])
                .per(50)
    @category_results_count = @results.select{|result| result.class == Category}.count
    @question_results_count = @results.select { |result| result.class == Question }.count
  end
end
