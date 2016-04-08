class Api::ShowsController < ApiController

  def show
    @show = Show.find(params[:id])
    respond_with @show, serializer: ShowSerializer
  end
end
