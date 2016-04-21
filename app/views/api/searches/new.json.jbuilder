json.query @query_input
json.category_count @category_results.count
json.question_count @question_results.count
json.categories @category_results do |category|
  json.name category.name
  json.count category.questions_count
  json.url  "#{api_category_url(category.id)}.json"
end
json.questions @question_results do |question|
  json.body question.body
  json.response question.response
  json.value question.value
  json.url  "#{api_question_url(question.id)}.json"
end