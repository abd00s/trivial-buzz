class Api::CategoriesController < ApiController
  def index
    limit = params[:popular].to_i if params[:popular]
    minimum = params[:minimum].to_i if params[:minimum]

    if limit.present? && limit <= 0
      display_error(400, "#{params[:popular]} is an invalid count limit. " \
      + "Proper usage: /categories.json?popular=5 to return 5 most popular categories")\
      and return
    end

    if minimum.present? && minimum <= 0
      display_error(400, "#{params[:minimum]} is an invalid count limit. " \
      + "Proper usage: /categories.json?minimum=300 to return categories with at least 300 questions")\
      and return
    end


    @categories = Kaminari.paginate_array(        # Kaminari workaround; otherwise call to .per reloads
      Category.most_common(limit)                 # "all" categories; and not the limits passed
        .minimum_question_count(minimum)
      )
      .page(params[:page])
      .per(10)

    if @categories.present?
      respond_with @categories, each_serializer: CategoryIndexSerializer,
        meta: pagination_dict(@categories)
    else
      display_error(404, "No categories with such limitations found") and return
    end

  end

  def show
    @category =
      begin
        Category.find(category_params[:id])
      rescue ActiveRecord::RecordNotFound
        display_error(404, "There is no category with ID #{category_params[:id]}") and return
      end
    respond_with @category, serializer: CategoryDetailSerializer, root: :category
  end

  private
  def category_params
    params.permit(:id)
  end
end
