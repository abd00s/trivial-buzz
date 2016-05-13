class SearchSwaggerModel
  include Swagger::Blocks

  swagger_schema :Search do
    property :id do
      key :type, :integer
      key :format, :int64
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
    property :round do
      key :'$ref', :Round
    end
  end
end