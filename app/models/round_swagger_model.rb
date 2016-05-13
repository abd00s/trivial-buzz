class RoundSwaggerModel
  include Swagger::Blocks

  swagger_schema :Round do
    property :id do
      key :type, :integer
      key :format, :int64
    end
    property :name do
      key :type, :string
    end
    property :round_url do
      key :type, :string
    end
  end

  swagger_schema :RoundsShows do
    property :id do
      key :type, :integer
      key :format, :int64
    end
    property :name do
      key :type, :string
    end
    property :round_url do
      key :type, :string
    end
    property :questions do
      key :type, :array
      key :items, {:'$ref' => 'QuestionsRoundsShows'}
    end
  end
end