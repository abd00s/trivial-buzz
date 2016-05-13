class ShowSwaggerModel
  include Swagger::Blocks

  swagger_schema :Shows_response do
    property :shows do
      key :type, :array
      key :items, {:'$ref' => 'Shows'}
    end
    property :meta do
      key :'$ref', :MetaModel
    end
  end

  swagger_schema :Show_response do
    property :show do
      key :'$ref', :Shows
    end
  end

  swagger_schema :Shows do
    property :id do
      key :type, :integer
      key :format, :int64
    end
    property :show_number do
      key :type, :integer
      key :format, :int64
    end
    property :air_date do
      key :type, :string
    end
    property :categories do
      key :type, :array
      key :items, {:'$ref' => 'CategoriesShows'}
    end
    property :rounds do
      key :type, :array
      key :items, {:'$ref' => 'RoundsShows'}
    end
  end
end