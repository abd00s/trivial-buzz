class QuestionsSwaggerController < Api::QuestionsController

# Reusable description for both routes
@@description = "</br> **question**:" \
                "</br> #{"&nbsp;"*4} **id**: Question ID" \
                "</br> #{"&nbsp;"*4} **body**: Jeopardy! clue" \
                "</br> #{"&nbsp;"*4} **response**: Jeopardy! answer" \
                "</br> #{"&nbsp;"*4} **value**: Question dollar value; Final Jeopardy questions have 0 value" \
                "</br> #{"&nbsp;"*4} **category**: Category of question" \
                "</br> #{"&nbsp;"*8} **id**: Category ID" \
                "</br> #{"&nbsp;"*8} **name**: Category name" \
                "</br> #{"&nbsp;"*8} **url**: link to category" \
                "</br> #{"&nbsp;"*4} **from_round**: Information on round in which question appeared" \
                "</br> #{"&nbsp;"*8} **id**: Round ID" \
                "</br> #{"&nbsp;"*8} **name**: Jeopardy!, Double Jeopardy! or Final Jeopardy!" \
                "</br> #{"&nbsp;"*8} **url**: link to round" \
                "</br> #{"&nbsp;"*8} **from_show**: Information on show in which round appeared" \
                "</br> #{"&nbsp;"*12} **id**: Show ID" \
                "</br> #{"&nbsp;"*12} **show_number**: Jeopardy! show number" \
                "</br> #{"&nbsp;"*12} **air_date**: Date the show aired YYYY-MM-DD" \
                "</br> #{"&nbsp;"*12} **url**: link to show"

swagger_path '/questions/{id}.json' do
    operation :get do
      key :description, "Returns a single question by ID." + @@description
      key :summary, 'Retrieve a single question by ID'
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
          key :'$ref', :Question_response
        end
      end
    end
  end

  swagger_path '/questions/random.json' do
    operation :get do
      key :description, 'Returns a random question.' + @@description
      key :summary, 'Retrieve a random question'
      key :operationId, 'findRandomQuestion'
      key :tags, [
        'question'
      ]
      parameter do
        key :name, :newer_than
        key :in, :query
        key :description, "Lower bound to search from (YYYY-MM-DD), starting from #{Show.order(:air_date).first.air_date} [Optional]"
        key :required, false
        key :type, :string
      end
      parameter do
        key :name, :older_than
        key :in, :query
        key :description, "Upper bound to search to (YYYY-MM-DD), up to #{Show.order(air_date: :desc).first.air_date} [Optional]"
        key :required, false
        key :type, :string
      end
      parameter do
        key :name, :value_equals
        key :in, :query
        key :description, "Limit results to questions with this value; May not be used with value_greater or value_less. For Final Jeopardy! (or tiebreaker) questions, enter value 0. [Optional]"
        key :required, false
        key :type, :integer
        key :format, :int64
      end
      parameter do
        key :name, :value_greater
        key :in, :query
        key :description, "Limit results to questions with value greater than (or equal to) this value [Optional]"
        key :required, false
        key :type, :integer
        key :format, :int64
      end
      parameter do
        key :name, :value_less
        key :in, :query
        key :description, "Limit results to questions with value less than (or equal to) this value excluding questions with value of zero [Optional]"
        key :required, false
        key :type, :integer
        key :format, :int64
      end
      response 200 do
        key :description, 'question response'
        schema do
          key :'$ref', :Question_response
        end
      end
    end
  end

  swagger_path '/questions.json' do
    operation :get do
      key :description, 'Returns paginated questions.' \
                        "</br> **questions**: Array containing questions" \
                        "</br> #{"&nbsp;"*4} **id**: Question ID" \
                        "</br> #{"&nbsp;"*4} **body**: Jeopardy! clue" \
                        "</br> #{"&nbsp;"*4} **response**: Jeopardy! answer" \
                        "</br> #{"&nbsp;"*4} **value**: Question dollar value; Final Jeopardy questions have 0 value" \
                        "</br> #{"&nbsp;"*4} **category**: Category of question" \
                        "</br> #{"&nbsp;"*8} **id**: Category ID" \
                        "</br> #{"&nbsp;"*8} **name**: Category name" \
                        "</br> #{"&nbsp;"*8} **url**: link to category" \
                        "</br> **meta**: Information on pages" \
                        "</br> #{"&nbsp;"*4} **current_page**: Current page" \
                        "</br> #{"&nbsp;"*4} **next_page**: Next page, if available" \
                        "</br> #{"&nbsp;"*4} **prev_page**: Previous page, if available" \
                        "</br> #{"&nbsp;"*4} **total_pages**: Total number of pages" \
                        "</br> #{"&nbsp;"*4} **total_count**: Total number of Question objects"
      key :summary, 'Retrieve all questions'
      key :operationId, 'findAllQuestions'
      key :tags, [
        'question'
      ]
      parameter do
        key :name, :newer_than
        key :in, :query
        key :description, "Lower bound to search from (YYYY-MM-DD), starting from #{Show.order(:air_date).first.air_date} [Optional]"
        key :required, false
        key :type, :string
      end
      parameter do
        key :name, :older_than
        key :in, :query
        key :description, "Upper bound to search to (YYYY-MM-DD), up to #{Show.order(air_date: :desc).first.air_date} [Optional]"
        key :required, false
        key :type, :string
      end
      parameter do
        key :name, :value_equals
        key :in, :query
        key :description, "Limit results to questions with this value; May not be used with value_greater or value_less. For Final Jeopardy! (or tiebreaker) questions, enter value 0. [Optional]"
        key :required, false
        key :type, :integer
        key :format, :int64
      end
      parameter do
        key :name, :value_greater
        key :in, :query
        key :description, "Limit results to questions with value greater than (or equal to) this value [Optional]"
        key :required, false
        key :type, :integer
        key :format, :int64
      end
      parameter do
        key :name, :value_less
        key :in, :query
        key :description, "Limit results to questions with value less than (or equal to) this value excluding questions with value of zero [Optional]"
        key :required, false
        key :type, :integer
        key :format, :int64
      end
      response 200 do
        key :description, 'question response'
        schema do
          key :'$ref', :QuestionsResponse
        end
      end
    end
  end
end