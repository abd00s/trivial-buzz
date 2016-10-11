# Special method to add functionality to SwaggerEngine's SwaggersControllers

SwaggerEngine::SwaggersController.class_eval do
  def index
    Tracker.track(
      request.remote_ip,
      "#{controller_name}##{action_name} visited",
      params
    )

    redirect_to swagger_path(@json_files.first[0]) if ( @json_files.size == 1 )
  end
end