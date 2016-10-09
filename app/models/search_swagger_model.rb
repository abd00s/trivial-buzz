class SearchSwaggerModel
  include Swagger::Blocks

  swagger_schema :SearchResponse do
    property :meta do
      key :'$ref', :SearchMeta
    end
    property :results do
      key :type, :array
      key :items, {:'$ref' => 'Search'}
    end
  end

  # Used for /searches/new.json
  swagger_schema :Search do
    property :result_type do
      key :type, :string
    end
    property :id do
      key :type, :integer
      key :format, :int64
    end
    property :name do
      key :type, :string
    end
    property :questions_count do
      key :type, :integer
      key :format, :int64
    end
    property :category do
      key :'$ref', :CategoriesShows
    end
    property :body do
      key :type, :string
    end
    property :response do
      key :type, :string
    end
    property :value do
      key :type, :integer
      key :format, :int64
    end
    property :url do
      key :type, :string
    end
  end

  # Used to prepare SearchResponse
  swagger_schema :SearchMeta do
    property :query do
      key :type, :string
    end
    property :current_page_category_count do
      key :type, :integer
      key :format, :int64
    end
    property :current_page_questions_count do
      key :type, :integer
      key :format, :int64
    end
    property :current_page do
      key :type, :integer
      key :format, :int64
    end
    property :next_page do
      key :type, :integer
      key :format, :int64
    end
    property :prev_page do
      key :type, :integer
      key :format, :int64
    end
    property :total_pages do
      key :type, :integer
      key :format, :int64
    end
    property :total_count do
      key :type, :integer
      key :format, :int64
    end
  end
end
