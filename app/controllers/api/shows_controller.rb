class Api::ShowsController < ApiController
  def index
    @shows = if params[:chrono_sort] == "old"
                Show.order(:air_date).page(params[:page]).per(3)
              elsif params[:chrono_sort] == "recent"
                Show.order(air_date: :desc).page(params[:page]).per(3)
              else
                Show.page(params[:page]).per(3)
              end
    respond_with @shows, each_serializer: ShowSerializer, meta: pagination_dict(@shows)
  end

  def show
    @show = Show.find(params[:id])
    respond_with @show, serializer: ShowSerializer
  end
end
