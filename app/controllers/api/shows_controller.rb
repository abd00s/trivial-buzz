class Api::ShowsController < ApiController
  def index
    sorting_order =
      if params[:chrono_sort] == "old"
        {air_date: :asc}
      elsif params[:chrono_sort] == "recent"
        {air_date: :desc}
      else
        {}
      end

    @shows = Show.order(sorting_order)
      .includes(rounds: [{questions: :category}])
      .page(params[:page]).per(3)

    respond_with @shows, each_serializer: ShowSerializer, meta: pagination_dict(@shows)
  end

  def show
    @show =
      begin
        Show.includes(rounds: [{questions: :category}]).find(show_params[:id])
      rescue ActiveRecord::RecordNotFound
        display_error("There is no show with ID #{show_params[:id]}") and return
      end
    respond_with @show, serializer: ShowSerializer
  end

  private
  def show_params
    params.permit(:id)
  end
end
