json_text = File.read(Rails.root.join('lib', 'seeds', 'questions.json'))
parsed_json = JSON.parse(json_text)
count = parsed_json.size
parsed_json.each do |question|

  s = Show.find_or_create_by(show_number: question["show_number"].to_i) do |show|
    show.air_date = Date.parse(question["air_date"])
  end

  r = Round.find_or_create_by(name: question["round"], show: s)

  c = Category.find_or_create_by(name: question["category"].downcase)

  if Question.find_by(body: question["question"]).present?
    next
  else
    q = Question.new
    q.body = question["question"]
    q.response = question["answer"]
    q.value = if question["value"]
      question["value"].gsub(/\D/,'').to_i
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