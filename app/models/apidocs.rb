class Apidocs < ActiveRecord::Base
  include Swagger::Blocks
  swagger_root do
    key :swagger, '2.0'
    info do
      key :version, '1.0.0'
      key :title, 'Jeopardy! API'
      key :description, 'JSON API serving roughly 200,000 trivia questions from the popular gameshow, Jeopardy! spanning 1984 - 2012.'

      contact do
        key :name, 'Abdullah Pharaon'
        key :url, 'https://github.com/abd00s/Jeopardy-API'
      end
    end
    tag do
      externalDocs do
        key :description, 'See on Github'
        key :url, 'https://swagger.io'
      end
    end
    key :host, 'localhost:3000/'
    key :basePath, 'api/v1'
    key :consumes, ['application/json']
    key :produces, ['application/json']
  end

  SWAGGERED_CLASSES = [
    Api::QuestionsController,
    Api::RoundsController,
    Api::SearchesController,
    Api::CategoriesController,
    Api::ShowsController,
    ErrorModel,
    self,
  ].freeze

  def self.run
    swagger_data = Swagger::Blocks.build_root_json(SWAGGERED_CLASSES)
    File.open('lib/swagger.json', 'w') { |file| file.write(swagger_data.to_json) }
  end
end