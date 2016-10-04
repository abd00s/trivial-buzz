class CategorySwaggerModel
  include Swagger::Blocks

  swagger_schema :Categories do
    property :id do
      key :type, :integer
      key :format, :int64
    end
    property :name do
      key :type, :string
    end
    property :url do
      key :type, :string
    end
    property :questions_count do
      key :type, :integer
      key :format, :int64
    end
  end

  swagger_schema :CategoriesShows do
    property :id do
      key :type, :integer
      key :format, :int64
    end
    property :name do
      key :type, :string
    end
    property :url do
      key :type, :string
    end
  end
end