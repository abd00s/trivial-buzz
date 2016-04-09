class Api::RoundsController < ApiController
  def show
    @round = Round.find(params[:id])
    respond_with @round, serializer: RoundSerializer
  end
end
