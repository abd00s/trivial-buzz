class CategoriesSwaggerController < Api::QuestionsController

  swagger_path '/categories.json' do
    operation :get do
      key :description, 'Returns all categories paginated with 10 per page.' \
                        "</br> **categories**: Array containing categories" \
                        "</br> #{"&nbsp;"*4} **id**: Category ID" \
                        "</br> #{"&nbsp;"*4} **name**: Category name" \
                        "</br> #{"&nbsp;"*4} **url**: Link to category" \
                        "</br> #{"&nbsp;"*4} **questions_count**: Number of questions having this category" \
                        "</br> #{"&nbsp;"*8} Note that this only includes shows revealed during the show" \
                        "</br> **meta**: Information on pages" \
                        "</br> #{"&nbsp;"*4} **current_page**: Current page" \
                        "</br> #{"&nbsp;"*4} **next_page**: Next page, if available" \
                        "</br> #{"&nbsp;"*4} **prev_page**: Previous page, if available" \
                        "</br> #{"&nbsp;"*4} **total_pages**: Total number of pages" \
                        "</br> #{"&nbsp;"*4} **total_count**: Total number of Category objects"
      key :operationId, 'findCategories'
      key :tags, [
        'category'
      ]
      parameter do
        key :name, :popular
        key :in, :query
        key :description, 'Limits results to X most popular categories, paginated with 10 per page. [Optional]'
        key :required, false
        key :type, :integer
        key :format, :int64
      end
      parameter do
        key :name, :page
        key :in, :query
        key :description, 'Go to particular page. [Optional]'
        key :required, false
        key :type, :integer
        key :format, :int64
      end
      response 200 do
        key :description, 'question response'
        schema do
          key :'$ref', :Categories_response
        end
      end
    end
  end

  swagger_path '/categories/{id}.json' do
    operation :get do
      key :description, 'Fetch category by ID.' \
                        "</br> **category**" \
                        "</br> #{"&nbsp;"*4} **id**: Category ID" \
                        "</br> #{"&nbsp;"*4} **name**: Category name" \
                        "</br> #{"&nbsp;"*4} **questions_count**: Number of questions having this category" \
                        "</br> #{"&nbsp;"*8} Note that this only includes shows revealed during the show" \
                        "</br> #{"&nbsp;"*4} **shows**: Array of shows in which this category appeared" \
                        "</br> #{"&nbsp;"*8} **id**: Show ID" \
                        "</br> #{"&nbsp;"*8} **show_number**: Jeopardy! show number" \
                        "</br> #{"&nbsp;"*8} **air_date**: Date the show aired YYYY-DD-MM" \
                        "</br> #{"&nbsp;"*8} **url**: Link to show" \
                        "</br> #{"&nbsp;"*4} **questions**: Array of questions with this category" \
                        "</br> #{"&nbsp;"*8} **id**: Question ID" \
                        "</br> #{"&nbsp;"*8} **body**: Jeopardy! clue" \
                        "</br> #{"&nbsp;"*8} **response**: Jeopardy! answer" \
                        "</br> #{"&nbsp;"*8} **value**: Question dollar value; Final Jeopardy questions have 0 value" \
                        "</br> #{"&nbsp;"*8} **url**: Link to question"
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
          key :'$ref', :Category_response
        end
      end
    end
  end
end