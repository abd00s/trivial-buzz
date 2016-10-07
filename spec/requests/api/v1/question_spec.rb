require 'rails_helper'

RSpec.describe Question, type: :request do
  describe "Endpoint: /questions/{id}.json" do
    context "with a valid ID" do
      it "returns a question object with all its relevant data" do
        get "/api/v1/questions/1.json"

        expect(response).to be_success

        expect(response_body_as_json).to have_key("question")

        expect(response_body_as_json["question"]).to \
          include("id", "body", "response", "value", "category", "from_round")

        expect(response_body_as_json["question"]["category"]).to be_a(Hash)

        expect(response_body_as_json["question"]["from_round"]).to be_a(Hash)

        expect(response_body_as_json["question"]["from_round"]["from_show"]).to be_a(Hash)
      end
    end

    context "with a valid ID but no matching record" do
      it "returns an error object with a 404 status" do
        invalid_id = Question.count + 1
        get "/api/v1/questions/#{invalid_id}.json"

        expect(response_body_as_json).to have_key("error")

        expect(response_body_as_json["error"]["status"]).to eq("404")
      end

      it "returns an error object with a message describing absence of matching record" do
        invalid_id = Question.count + 1
        get "/api/v1/questions/#{invalid_id}.json"

        expect(response_body_as_json["error"]["message"]).to match(/no question with ID/)
      end
    end

    context "with an invalid ID" do
      it "returns an error object with a 404 status" do
        get "/api/v1/questions/X.json"

        expect(response_body_as_json).to have_key("error")

        expect(response_body_as_json["error"]["status"]).to eq("404")
      end

      it "returns an error object with a message describing bad request input" do
        get "/api/v1/questions/X.json"

        expect(response_body_as_json["error"]["message"]).to match(/no question with ID/)
      end
    end
  end

  describe "Endpoint: /questions/random.json" do
    let(:first_air_date) { Show.order(:air_date).first.air_date }
    let(:last_air_date) { Show.order(:air_date).last.air_date }
    let(:mid_air_date) { Show.find(Show.count/2).air_date }

    context "without any params" do
      it "returns a single question object with all its relevant data" do
        get "/api/v1/questions/random.json"

        expect(response).to be_success

        expect(response_body_as_json).to have_key("question")

        expect(response_body_as_json["question"]).to \
          include("id", "body", "response", "value", "category", "from_round")

        expect(response_body_as_json["question"]["category"]).to be_a(Hash)

        expect(response_body_as_json["question"]["from_round"]).to be_a(Hash)

        expect(response_body_as_json["question"]["from_round"]["from_show"]).to be_a(Hash)
      end
    end

    context "with valid param `?newer_than=`" do
      it "returns a question object that aired after param with all its relevant data" do
        newer_than = random_date_between(first_air_date, last_air_date) # "YYYY-MM-DD"

        get "/api/v1/questions/random.json?newer_than=#{newer_than}"

        expect(response).to be_success

        response_question_air_date = \
          response_body_as_json["question"]["from_round"]["from_show"]["air_date"]

        expect(Date.parse(response_question_air_date)).to be >= Date.parse(newer_than)
      end
    end

    context "with valid param `?newer_than=` but no matching record (out of covered period)" do
      it "returns an error object with a 404 status" do
        newer_than = random_date_between(last_air_date + 1.day, last_air_date + 10.days) # "YYYY-MM-DD"

        get "/api/v1/questions/random.json?newer_than=#{newer_than}"

        expect(response_body_as_json).to have_key("error")

        expect(response_body_as_json["error"]["status"]).to eq("404")
      end

      it "returns an error object with a message describing correct period covered" do
        newer_than = random_date_between(last_air_date + 1.day, last_air_date + 10.days) # "YYYY-MM-DD"

        get "/api/v1/questions/random.json?newer_than=#{newer_than}"

        expect(response_body_as_json["error"]["message"]).to match(/bounds are outside of valid range/)
      end
    end

    context "with invalid param ?newer_than=nineties" do
      it "returns an error object with a 400 status" do
        get "/api/v1/questions/random.json?newer_than=nineties"

        expect(response_body_as_json).to have_key("error")

        expect(response_body_as_json["error"]["status"]).to eq("400")
      end

      it "returns an error object with a message describing bad request input" do
        get "/api/v1/questions/random.json?newer_than=nineties"

        expect(response_body_as_json["error"]["message"]).to match(/Invalid lower bound/)
      end
    end

    context "with valid param ?older_than=" do
      it "returns a question object that aired before param with all its relevant data" do
        older_than = random_date_between(first_air_date, last_air_date) # "YYYY-MM-DD"

        get "/api/v1/questions/random.json?older_than=#{older_than}"

        expect(response).to be_success

        response_question_air_date = \
          response_body_as_json["question"]["from_round"]["from_show"]["air_date"]

        expect(Date.parse(response_question_air_date)).to be <= Date.parse(older_than)
      end
    end

    context "with valid param `?older_than=` but no matching record (out of covered period)" do
      it "returns an error object with a 404 status" do
        older_than = random_date_between(first_air_date - 10.days, first_air_date - 1.day) # "YYYY-MM-DD"

        get "/api/v1/questions/random.json?older_than=#{older_than}"

        expect(response_body_as_json).to have_key("error")

        expect(response_body_as_json["error"]["status"]).to eq("404")
      end

      it "returns an error object with a message describing correct period covered" do
        older_than = random_date_between(first_air_date - 10.days, first_air_date - 1.day) # "YYYY-MM-DD"

        get "/api/v1/questions/random.json?older_than=#{older_than}"

        expect(response_body_as_json["error"]["message"]).to match(/bounds are outside of valid range/)
      end
    end

    context "with invalid param ?older_than=nineties" do
      it "returns an error object with a 400 status" do
        get "/api/v1/questions/random.json?older_than=nineties"

        expect(response_body_as_json).to have_key("error")

        expect(response_body_as_json["error"]["status"]).to eq("400")
      end

      it "returns an error object with a message describing bad request input" do
        get "/api/v1/questions/random.json?older_than=nineties"

        expect(response_body_as_json["error"]["message"]).to match(/Invalid upper bound/)
      end
    end

    context "with valid param range; `?newer_than=` being before `&older_than=`" do
      it "returns a question object that aired between param range with all its relevant data" do
        newer_than = random_date_between(first_air_date, mid_air_date) # "YYYY-MM-DD"
        older_than = random_date_between(mid_air_date, last_air_date) # "YYYY-MM-DD"

        get "/api/v1/questions/random.json?newer_than=#{newer_than}&older_than=#{older_than}"

        expect(response).to be_success

        response_question_air_date = \
          response_body_as_json["question"]["from_round"]["from_show"]["air_date"]

        expect(Date.parse(response_question_air_date)).to \
          be_between(Date.parse(newer_than), Date.parse(older_than))
      end
    end

    context "with invalid param range; `?newer_than=` being later than `&older_than=`" do
      let(:older_than) { random_date_between(first_air_date, mid_air_date) } # "YYYY-MM-DD"
      let(:newer_than) { random_date_between(mid_air_date, last_air_date) } # "YYYY-MM-DD"

      it "returns an error object with a 400 status" do
        get "/api/v1/questions/random.json?newer_than=#{newer_than}&older_than=#{older_than}"

        expect(response_body_as_json).to have_key("error")

        expect(response_body_as_json["error"]["status"]).to eq("400")
      end

      it "returns an error object with a message describing bad request input; minimum is greater than maximum" do
        get "/api/v1/questions/random.json?newer_than=#{newer_than}&older_than=#{older_than}"

        expect(response_body_as_json["error"]["message"]).to match(/Invalid range/)
      end
    end
  end
end