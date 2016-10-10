json_text = File.read(Rails.root.join('lib', 'seeds', 'questions.json'))
parsed_json = JSON.parse(json_text)
count = parsed_json.size

number_of_questions_already_seeded = Question.count - 1

for i in number_of_questions_already_seeded...parsed_json.size
# parsed_json.each do |question|

  if Question.find_by(body: parsed_json[i]["question"]).present?
    next
  else
    s = Show.find_or_create_by(show_number: parsed_json[i]["show_number"].to_i) do |show|
      show.air_date = Date.parse(parsed_json[i]["air_date"])
    end

    r = Round.find_or_create_by(name: parsed_json[i]["round"], show: s)

    c = Category.find_or_create_by(name: parsed_json[i]["category"].downcase)

    q = Question.new
    q.body = parsed_json[i]["question"]
    q.response = parsed_json[i]["answer"]
    q.value = if parsed_json[i]["value"]
      parsed_json[i]["value"].gsub(/\D/,'').to_i
    else
      0
    end
    q.category = c
    q.round = r
    q.save
  end

  puts count
  count -= 1

end

puts "There are now #{Show.count} rows in the shows table"
puts "There are now #{Round.count} rows in the rounds table"
puts "There are now #{Category.count} rows in the categories table"
puts "There are now #{Question.count} rows in the questions table"
puts "Raw input was #{parsed_json.size} questions"