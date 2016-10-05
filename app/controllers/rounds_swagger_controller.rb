class RoundsSwaggerController < Api::QuestionsController

  swagger_path '/rounds/{id}.json' do
    operation :get do
      key :description, "Use to retrieve a single round by ID. " \
                        "</br> _Explanation of response attributes_" \
                        "</br> **round**" \
                        "</br> #{"&nbsp;"*4} **id**: ID of round" \
                        "</br> #{"&nbsp;"*4} **name**: Jeopardy!, Double Jeopardy! or Final Jeopardy!" \
                        "</br> #{"&nbsp;"*4} **from_show**: Information about show where this round appeared" \
                        "</br> #{"&nbsp;"*8} **id**: ID of show" \
                        "</br> #{"&nbsp;"*8} **show_number**: Jeopardy! show number" \
                        "</br> #{"&nbsp;"*8} **air_date**: Date the show aired YYYY-DD-MM" \
                        "</br> #{"&nbsp;"*8} **url**: Link to show" \
                        "</br> #{"&nbsp;"*4} **categories**: Array of categories appearing in round" \
                        "</br> #{"&nbsp;"*8} **id**: ID of category" \
                        "</br> #{"&nbsp;"*8} **name**: Category name" \
                        "</br> #{"&nbsp;"*8} **url**: Link to category" \
                        "</br> #{"&nbsp;"*4} **questions**: Array of questions appearing in round" \
                        "</br> #{"&nbsp;"*8} **id**: ID of question" \
                        "</br> #{"&nbsp;"*8} **body**: Jeopardy! clue" \
                        "</br> #{"&nbsp;"*8} **response**: Jeopardy! answer" \
                        "</br> #{"&nbsp;"*8} **value**: Question dollar value; Final Jeopardy questions have 0 value" \
                        "</br> #{"&nbsp;"*8} **url**: Link to question" \
                        "</br> #{"&nbsp;"*8} **category**: Category of question" \
                        "</br> #{"&nbsp;"*12} **id**: ID of category" \
                        "</br> #{"&nbsp;"*12} **name**: Category name" \
                        "</br> #{"&nbsp;"*12} **url**: link to category"
      key :summary, 'Retrieve a single round by ID'
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
          key :'$ref', :Round_response
        end
      end
    end
  end

end