class QuestionSwaggerModel
  include Swagger::Blocks

  swagger_schema :Question_response do
    property :question do
      key :'$ref', :Question
    end
  end

  swagger_schema :Question do
    key :required, [:id]
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
    property :category do
      key :'$ref', :CategoriesShows
    end
    property :from_round do
      key :'$ref', :QuestionRound
    end
  end

  # For use in /shows.json and /shows/{id}.json
  swagger_schema :QuestionsRoundsShows do
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
    property :url do
      key :type, :string
    end
    property :category do
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

  # For use in /searches/new.json
  swagger_schema :QuestionSearches do
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
end
