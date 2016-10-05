class CategorySwaggerModel
  include Swagger::Blocks


  # Used for /categories.json
  swagger_schema :Categories_response do
    property :categories do
      key :type, :array
      key :items, {:'$ref' => 'CategoriesIndex'}
    end
    property :meta do
      key :'$ref', :MetaModel
    end
  end

  # Used to set up Categories_response
  swagger_schema :CategoriesIndex do
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

  # Used for /questions/{id}.json
  # /questions/random.json
  # /rounds/{id}.json
  # /searches/new.json
  # /shows.json
  # /shows/{id}.json
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