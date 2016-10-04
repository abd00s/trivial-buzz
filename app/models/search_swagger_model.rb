class SearchSwaggerModel
  include Swagger::Blocks

  swagger_schema :Search do
    property :query do
      key :type, :string
    end
    property :category_count do
      key :type, :integer
      key :format, :int64
    end
    property :questions_count do
      key :type, :integer
      key :format, :int64
    end
    property :categories do
      key :type, :array
      key :items, {:'$ref' => 'CategoriesShows'}
    end
    property :questions do
      key :type, :array
      key :items, {:'$ref' => 'QuestionSearches'}
    end
  end
end
