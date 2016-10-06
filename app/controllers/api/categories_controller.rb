class Api::CategoriesController < ApiController
  def index
    @categories =
      if params[:popular].present?
        limit = params[:popular].to_i
        if limit <= 0
          render json: {Error: "#{params[:popular]} is an invalid count limit. " \
          + "Proper usage: /categories.json?popular=5 to return 5 most popular categories"} \
          and return
        end
        categories_array = Category.most_common(limit).to_a
        Kaminari.paginate_array(categories_array) # Kaminari workaround; otherwise
        # call to .per reloads "all" categories; and not the limit passed to .most_common
      else
        Category.all
      end.page(params[:page]).per(10)

    respond_with @categories, each_serializer: CategoryIndexSerializer,
      meta: pagination_dict(@categories)
  end

  def show
    @category =
      begin
        Category.find(category_params[:id])
      rescue ActiveRecord::RecordNotFound
        display_error("There is no category with ID #{category_params[:id]}") and return
      end
    respond_with @category, serializer: CategoryDetailSerializer, root: :category
  end

  private
  def category_params
    params.permit(:id)
  end
end
