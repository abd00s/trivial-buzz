class CategoriesSwaggerController < Api::QuestionsController

  swagger_path '/categories.json' do
    operation :get do
      key :description, 'Returns all categories paginated with 10 per page.'
      key :operationId, 'findCategories'
      key :tags, [
        'category'
      ]
      parameter do
        key :name, :popular
        key :in, :query
        key :description, 'Limits results to X most popular categories, paginated with 10 per page.'
        key :required, false
        key :type, :integer
        key :format, :int64
      end
      parameter do
        key :name, :page
        key :in, :query
        key :description, 'Go to particular page.'
        key :required, false
        key :type, :integer
        key :format, :int64
      end
      response 200 do
        key :description, 'question response'
        schema do
          key :'$ref', :Categories
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

  swagger_path '/categories/{id}.json' do
    operation :get do
      key :description, 'Fetch category by ID.'
      key :operationId, 'findCategoriesById'
      key :tags, [
        'category'
      ]
      parameter do
        key :name, :id
        key :in, :path
        key :description, 'ID of category to fetch'
        key :required, true
        key :type, :integer
        key :format, :int64
      end
      response 200 do
        key :description, 'question response'
        schema do
          key :'$ref', :Categories
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