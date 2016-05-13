class QuestionSwaggerModel
  include Swagger::Blocks

  swagger_schema :Question do
    key :required, [:id]
    property :id do
      key :type, :integer
      key :format, :int64
    end
    property :body do
      key :type, :string
    end
    property :tag do
      key :type, :string
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
    property :question_url do
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
      property :category_url do
        key :type, :string
      end
    end
  end
end
