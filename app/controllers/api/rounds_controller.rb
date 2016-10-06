class Api::RoundsController < ApiController
  def show
    @round =
      begin
        Round.find(round_params[:id])
      rescue ActiveRecord::RecordNotFound
        display_error(404,"There is no round with ID #{round_params[:id]}") and return
      end
    respond_with @round, serializer: RoundSerializer
  end

  private
  def round_params
    params.permit(:id)
  end
end
