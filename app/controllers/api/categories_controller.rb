class Api::CategoriesController < ApiController
  def show
    @category = Category.find(params[:id])
    respond_with @category, serializer: CategorySerializer
  end
end
