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
  json.category question.category.name
  json.from_round "#{api_round_url(question.round)}.json"
  json.from_show "#{api_show_url(question.round.show)}.json"
  json.url  "#{api_question_url(question.id)}.json"
end