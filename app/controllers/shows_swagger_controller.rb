class ShowsSwaggerController < Api::QuestionsController

  swagger_path '/shows.json' do
    operation :get do
      key :description, "Use to retrieve all shows with three objects per page. " \
                        "</br> _Explanation of response attributes_" \
                        "</br> **shows**: Array of 3 shows" \
                        "</br> #{"&nbsp;"*4} **id**: ID of show" \
                        "</br> #{"&nbsp;"*4} **show_number**: Jeopardy! show number" \
                        "</br> #{"&nbsp;"*4} **air_date**: Date the show aired YYYY-DD-MM" \
                        "</br> #{"&nbsp;"*4} **categories**: Array of categories appearing in show" \
                        "</br> #{"&nbsp;"*8} **id**: ID of category" \
                        "</br> #{"&nbsp;"*8} **name**: Category name" \
                        "</br> #{"&nbsp;"*8} **url**: Link to category" \
                        "</br> #{"&nbsp;"*4} **rounds**: Array of rounds appearing in show" \
                        "</br> #{"&nbsp;"*8} **id**: ID of rounds" \
                        "</br> #{"&nbsp;"*8} **name**: Jeopardy!, Double Jeopardy! or Final Jeopardy!" \
                        "</br> #{"&nbsp;"*8} **url**: Link to round" \
                        "</br> #{"&nbsp;"*8} **questions**: Array of questions appearing in round" \
                        "</br> #{"&nbsp;"*12} **id**: ID of question" \
                        "</br> #{"&nbsp;"*12} **body**: Jeopardy! clue" \
                        "</br> #{"&nbsp;"*12} **response**: Jeopardy! answer" \
                        "</br> #{"&nbsp;"*12} **value**: Question dollar value; Final Jeopardy questions have 0 value" \
                        "</br> #{"&nbsp;"*12} **url**: Link to question" \
                        "</br> #{"&nbsp;"*12} **category**: Category of question" \
                        "</br> #{"&nbsp;"*16} **id**: ID of category" \
                        "</br> #{"&nbsp;"*16} **name**: Category name" \
                        "</br> #{"&nbsp;"*16} **url**: link to category" \
                        "</br> **meta**: Information on pages" \
                        "</br> #{"&nbsp;"*4} **current_page**: Current page" \
                        "</br> #{"&nbsp;"*4} **next_page**: Next page, if available" \
                        "</br> #{"&nbsp;"*4} **prev_page**: Previous page, if available" \
                        "</br> #{"&nbsp;"*4} **total_pages**: Total number of pages" \
                        "</br> #{"&nbsp;"*4} **total_count**: Total number of Show objects"
      key :summary, 'Retrieve all shows paginated in 3\'s'
      key :operationId, 'findShows'
      key :tags, [
        'show'
      ]
      parameter do
        key :name, :page
        key :in, :query
        key :description, 'Go to particular page. [Optional]'
        key :required, false
        key :type, :integer
        key :format, :int64
      end
      parameter do
        key :name, :chrono_sort
        key :in, :query
        key :description, '"old" to sort in ascending chronological order, "recent" for descending. [Optional]'
        key :required, false
        key :type, :string
      end
      response 200 do
        key :description, 'question response'
        schema do
          key :'$ref', :Shows_response
        end
      end
    end
  end

  swagger_path '/shows/{id}.json' do
    operation :get do
      key :description, "Use to retrieve one show by id " \
                        "</br> _Explanation of response attributes_" \
                        "</br> **show**" \
                        "</br> #{"&nbsp;"*4} **id**: ID of show" \
                        "</br> #{"&nbsp;"*4} **show_number**: Jeopardy! show number" \
                        "</br> #{"&nbsp;"*4} **air_date**: Date the show aired YYYY-DD-MM" \
                        "</br> #{"&nbsp;"*4} **categories**: Array of categories appearing in show" \
                        "</br> #{"&nbsp;"*8} **id**: ID of category" \
                        "</br> #{"&nbsp;"*8} **name**: Category name" \
                        "</br> #{"&nbsp;"*8} **url**: Link to category" \
                        "</br> #{"&nbsp;"*4} **rounds**: Array of rounds appearing in show" \
                        "</br> #{"&nbsp;"*8} **id**: ID of rounds" \
                        "</br> #{"&nbsp;"*8} **name**: Jeopardy!, Double Jeopardy! or Final Jeopardy!" \
                        "</br> #{"&nbsp;"*8} **url**: Link to round" \
                        "</br> #{"&nbsp;"*8} **questions**: Array of questions appearing in round" \
                        "</br> #{"&nbsp;"*12} **id**: ID of question" \
                        "</br> #{"&nbsp;"*12} **body**: Jeopardy! clue" \
                        "</br> #{"&nbsp;"*12} **response**: Jeopardy! answer" \
                        "</br> #{"&nbsp;"*12} **value**: Question dollar value; Final Jeopardy questions have 0 value" \
                        "</br> #{"&nbsp;"*12} **url**: Link to question" \
                        "</br> #{"&nbsp;"*12} **category**: Category of question" \
                        "</br> #{"&nbsp;"*16} **id**: ID of category" \
                        "</br> #{"&nbsp;"*16} **name**: Category name" \
                        "</br> #{"&nbsp;"*16} **url**: link to category"
      key :summary, 'Retrieve a single show by ID'
      key :operationId, 'findShowById'
      key :tags, [
        'show'
      ]
      parameter do
        key :name, :id
        key :in, :path
        key :description, 'ID of show to fetch.'
        key :required, true
        key :type, :integer
        key :format, :int64
      end
      response 200 do
        key :description, 'show response'
        schema do
          key :'$ref', :Show_response
        end
      end
    end
  end
end