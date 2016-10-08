class SearchesSwaggerController < Api::QuestionsController

  swagger_path '/searches/new.json' do
    operation :get do
      key :description, 'Search across questions and categories' \
                        "</br> _Explanation of response attributes_" \
                        "</br> **query**: Search term" \
                        "</br> **category_count**: Number of categories matching query" \
                        "</br> **question_count**: Number of questions matching query" \
                        "</br> **categories**: Array containing matching categories" \
                        "</br> #{"&nbsp;"*4} **id**: Category ID" \
                        "</br> #{"&nbsp;"*4} **name**: Name of category" \
                        "</br> #{"&nbsp;"*4} **url**: Link to category" \
                        "</br> **questions**: Array containing matching questions" \
                        "</br> #{"&nbsp;"*4} **category**: Category of the question" \
                        "</br> #{"&nbsp;"*4} **body**: Jeopardy! clue" \
                        "</br> #{"&nbsp;"*4} **response**: Jeopardy! answer" \
                        "</br> #{"&nbsp;"*4} **value**: Question dollar value; Final Jeopardy questions have 0 value" \
                        "</br> #{"&nbsp;"*4} **url**: Link to question"
      key :summary, 'Search across questions and categories'
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
    end
  end
end