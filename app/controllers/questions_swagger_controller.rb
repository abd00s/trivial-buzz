class QuestionsSwaggerController < Api::QuestionsController

swagger_path '/questions/{id}.json' do
    operation :get do
      key :description, 'Returns a single question.'
      key :operationId, 'findQuestionById'
      key :tags, [
        'question'
      ]
      parameter do
        key :name, :id
        key :in, :path
        key :description, 'ID of question to fetch'
        key :required, true
        key :type, :integer
        key :format, :int64
      end
      response 200 do
        key :description, 'question response'
        schema do
          key :'$ref', :Question
        end
      end
      response :default do
        key :description, 'unexpected error'
        schema do
          key :'$ref', :ErrorModel
        end
      end
    end
  end

  swagger_path '/questions/random.json' do
    operation :get do
      key :description, 'Returns a random question.'
      key :operationId, 'findRandomQuestion'
      key :tags, [
        'question'
      ]
      parameter do
        key :name, :newer_than
        key :in, :query
        key :description, "Lower bound to search from (YYYY-DD-MM), starting from #{Show.order(:air_date).first.air_date}"
        key :required, false
        key :type, :string
      end
      parameter do
        key :name, :older_than
        key :in, :query
        key :description, "Upper bound to search to (YYYY-DD-MM), up to #{Show.order(air_date: :desc).first.air_date}"
        key :required, false
        key :type, :string
      end
      response 200 do
        key :description, 'question response'
        schema do
          key :'$ref', :Question
        end
      end
      response :default do
        key :description, 'unexpected error'
        schema do
          key :'$ref', :ErrorModel
        end
      end
    end
  end
end