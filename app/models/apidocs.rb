class Apidocs < ActiveRecord::Base
  include Swagger::Blocks
  swagger_root do
    key :swagger, '2.0'
    info do
      key :version, '1.0.0'
      key :title, 'Trivial Buzz'
      key :description, "JSON API serving roughly 200,000 trivia questions from the popular gameshow, Jeopardy! spanning 1984 - 2012. This project is unaffiliated with the Jeopardy! gameshow and claims no ownership of the questions. Questions were obtained by crawling www.j-archive.com . This is a project developed in my free time using Ruby on Rails on the backend and Swagger for documentation. An API key is not required. See more at https://github.com/abd00s/trivial-buzz"

      contact do
        key :name, 'Abdullah Pharaon'
        key :url, 'http://abdullahonline.co/'
      end
    end
    key :host, 'trivial-buzz.herokuapp.com'
    key :basePath, '/api/v1'
    key :consumes, ['application/json']
    key :produces, ['application/json']
  end

  SWAGGERED_CLASSES = [
    QuestionsSwaggerController,
    RoundsSwaggerController,
    SearchesSwaggerController,
    CategoriesSwaggerController,
    ShowsSwaggerController,
    QuestionSwaggerModel,
    RoundSwaggerModel,
    SearchSwaggerModel,
    ShowSwaggerModel,
    CategorySwaggerModel,
    ErrorModel,
    MetaSwaggerModel,
    self,
  ].freeze

  def self.run
    swagger_data = Swagger::Blocks.build_root_json(SWAGGERED_CLASSES)
    File.open('lib/swagger.json', 'w') { |file| file.write(swagger_data.to_json) }
  end
end