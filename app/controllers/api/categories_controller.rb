class Api::CategoriesController < ApiController
  def index
    @categories = Category.page(params[:page]).per(10)
    respond_with @categories, each_serializer: CategoryIndexSerializer, meta: pagination_dict(@categories)
  end

  def show
    @category = Category.find(params[:id])
    respond_with @category, serializer: CategoryDetailSerializer, root: :category
  end
end
