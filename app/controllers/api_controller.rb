class ApiController < ApplicationController
  include Swagger::Blocks

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

  def display_error(message)
    render json: {Error: "#{message}"}
  end
end
