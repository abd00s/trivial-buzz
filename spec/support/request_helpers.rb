module Requests
  def response_body_as_json
    JSON.parse(response.body)
  end

  def random_date_between(date1, date2)
    parsed_date1 = Time.parse(date1.to_s)
    parsed_date2 = Time.parse(date2.to_s)
    random_date = Time.at((parsed_date2.to_f - parsed_date1.to_f)*rand + parsed_date1.to_f)
    random_date.strftime("%Y-%m-%d")
  end
end