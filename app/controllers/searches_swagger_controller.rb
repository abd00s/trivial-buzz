class SearchesSwaggerController < Api::QuestionsController

  swagger_path '/searches/new.json' do
    operation :get do
      key :description, 'Search across questions and categories'
      key :operationId, 'search'
      key :tags, [
        'search'
      ]
      parameter do
        key :name, :query
        key :in, :query
        key :description, "Search term or phrase."
        key :required, true
        key :type, :string
      end
      response 200 do
        key :description, 'search response'
        schema do
          key :'$ref', :Search
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