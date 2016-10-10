json.meta {
  json.query @query_input
  json.category_count @category_results_count
  json.question_count @question_results_count
  json.current_page @paginated_results.current_page
  json.next_page @paginated_results.next_page
  json.prev_page @paginated_results.prev_page
  json.total_pages @paginated_results.total_pages
  json.total_count @paginated_results.total_count
}
json.results @paginated_results do |result|
  if result.respond_to? :questions_count
    json.result_type "category"
    json.id result.id
    json.name result.name
    json.questions_count result.questions_count
    json.url  "#{api_category_url(result.id)}.json"
  else
    json.result_type "question"
    json.id result.id
    json.body result.body
    json.response result.response
    json.category do
      json.id result.category.id
      json.name result.category.name
      json.url "#{api_category_url(result.category.id)}.json"
    end
    json.value result.value
    json.url  "#{api_question_url(result.id)}.json"
  end
end
