json.meta {
  json.query @query_input
  json.current_page_category_count @category_results_count
  json.current_page_question_count @question_results_count
  json.current_page @results.current_page
  json.next_page @results.next_page
  json.prev_page @results.prev_page
  json.total_pages @results.total_pages
  json.total_count @results.total_count
}
json.results @results do |result|
  if result.respond_to? :questions_count
    json.result_type "category"
    json.id result.id
    json.name result.name
    json.questions_count result.questions_count
    json.url  "#{api_category_url(result.id)}.json"
  else
    json.result_type "question"
    json.id result.id
    json.category result.category.name
    json.body result.body
    json.response result.response
    json.value result.value
    json.url  "#{api_question_url(result.id)}.json"
  end
end
