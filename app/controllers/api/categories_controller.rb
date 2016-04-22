class Api::CategoriesController < ApiController
  def index
    @categories =
      if params[:popular].present?
        limit = params[:popular].to_i
        categories_array = Category.most_common(limit).to_a
        Kaminari.paginate_array(categories_array) # Kaminari workaround; otherwise
        # call to .per reload "all" categories; and not the limit passed to .most_common
      else
        Category.all
      end.page(params[:page]).per(10)

    respond_with @categories, each_serializer: CategoryIndexSerializer,
      meta: pagination_dict(@categories)
  end

  def show
    @category = Category.find(params[:id])
    respond_with @category, serializer: CategoryDetailSerializer, root: :category
  end
end
