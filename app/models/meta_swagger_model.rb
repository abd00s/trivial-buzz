class MetaSwaggerModel
  include Swagger::Blocks

  # Used for /categories.json
  # /shows.json
  swagger_schema :MetaModel do
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