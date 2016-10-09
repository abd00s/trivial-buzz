class ApiController < ApplicationController
  include Swagger::Blocks
  rescue_from StandardError, with: :something_went_wrong

  # after_action :track_analytics

  respond_to :json

  def pagination_dict(object)
    {
      current_page: object.current_page,
      next_page: object.next_page,
      prev_page: object.prev_page,
      total_pages: object.total_pages,
      total_count: object.total_count
    }
  end

  def display_error(status, message)
    render json: {"error": {
      "status": "#{status}",
      "message": "#{message}"
      }
    }
  end

  def something_went_wrong(exception)
    display_error(500,"Something went wrong, please try again.")
    puts "There was an error on this request:"
    puts exception.message
  end

  def track_analytics
    Tracker.track(
      request.remote_ip,
      "#{controller_name}##{action_name} visited",
      params
    )
  rescue
    return
  end
end
