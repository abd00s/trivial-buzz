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
    @show = Show.includes(rounds: [{questions: :category}]).find(params[:id])
    respond_with @show, serializer: ShowSerializer
  end
end
