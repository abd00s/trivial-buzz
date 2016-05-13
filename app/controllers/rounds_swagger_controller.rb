class RoundsSwaggerController < Api::QuestionsController

  swagger_path '/rounds/{id}.json' do
    operation :get do
      key :description, 'Get one round by ID'
      key :operationId, 'findRoundById'
      key :tags, [
        'round'
      ]
      parameter do
        key :name, :id
        key :in, :path
        key :description, 'ID of round to fetch.'
        key :required, true
        key :type, :integer
        key :format, :int64
      end
      response 200 do
        key :description, 'show response'
        schema do
          key :'$ref', :Round
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