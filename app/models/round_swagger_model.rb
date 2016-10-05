class RoundSwaggerModel
  include Swagger::Blocks

  # Used for /round/{id}.json
  swagger_schema :Round_response do
    property :round do
      key :'$ref', :Round
    end
  end

  # Used to set up Round_response
  swagger_schema :Round do
    property :id do
      key :type, :integer
      key :format, :int64
    end
    property :name do
      key :type, :string
    end
    property :from_show do
      key :'$ref', :ShowRound
    end
    property :categories do
      key :type, :array
      key :items, {:'$ref' => 'CategoriesShows'}
    end
    property :questions do
      key :type, :array
      key :items, {:'$ref' => 'QuestionsRoundsShows'}
    end
  end

  # Used for /shows/{id}.json
  swagger_schema :RoundsShows do
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
    property :questions do
      key :type, :array
      key :items, {:'$ref' => 'QuestionsRoundsShows'}
    end
  end

  # Used in ../questions/{id}.json
  swagger_schema :QuestionRound do
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
    property :from_show do
      key :'$ref', :ShowRound
    end
  end
end