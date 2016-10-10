class SearchesSwaggerController < Api::QuestionsController

  swagger_path '/search.json' do
    operation :get do
      key :description, 'Search across questions and categories' \
                        "</br> _Explanation of response attributes_" \
                        "</br> **meta**: Object explaining results and pages" \
                        "</br> #{"&nbsp;"*4} **query**: Search term" \
                        "</br> #{"&nbsp;"*4} **category_count**: Number of categories matching query" \
                        "</br> #{"&nbsp;"*4} **question_count**: Number of questions matching query" \
                        "</br> #{"&nbsp;"*4} **current_page**: Current page" \
                        "</br> #{"&nbsp;"*4} **next_page**: Next page, if available" \
                        "</br> #{"&nbsp;"*4} **prev_page**: Previous page, if available" \
                        "</br> #{"&nbsp;"*4} **total_pages**: Total number of pages" \
                        "</br> #{"&nbsp;"*4} **total_count**: Total number of search results" \
                        "</br> **results**: Array containing results; Note: results are either a Question or a Category" \
                        "</br> #{"&nbsp;"*4} **result_type**: Question or Category" \
                        "</br> #{"&nbsp;"*4} **id**: Question/Category ID" \
                        "</br> #{"&nbsp;"*4} **name**: Name of category (Only shows when result type is Category)" \
                        "</br> #{"&nbsp;"*4} **questions_count**: Number of questions having this category (Only shows when result type is Category)" \
                        "</br> #{"&nbsp;"*4} **category**: Category of question (Only shows when result type is Question)" \
                        "</br> #{"&nbsp;"*8} **id**: Category ID" \
                        "</br> #{"&nbsp;"*8} **name**: Category name" \
                        "</br> #{"&nbsp;"*8} **url**: Link to category" \
                        "</br> #{"&nbsp;"*4} **body**: Jeopardy! clue (Only shows when result type is Question)" \
                        "</br> #{"&nbsp;"*4} **response**: Jeopardy! answer (Only shows when result type is Question)" \
                        "</br> #{"&nbsp;"*4} **value**: Question dollar value; Final Jeopardy questions have 0 value (Only shows when result type is Question)" \
                        "</br> #{"&nbsp;"*4} **url**: Link to question or category"
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
      parameter do
        key :name, :only
        key :in, :query
        key :description, "Limit results to either questions or categories only. Valid values are `Question` and `Category` [Optional]"
        key :required, false
        key :type, :string
      end
      response 200 do
        key :description, 'search response'
        schema do
          key :'$ref', :SearchResponse
        end
      end
    end
  end
end