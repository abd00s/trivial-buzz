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

#   describe "Endpoint: /questions/random.json" do
#     context "with valid param &newer_than=2010_01_01" do
#       it "returns a question object that aired after param with all its relevant data" do

#       end
#     end

#     context "with invalid param &newer_than=nineties" do
#       it "returns an error object with a 400 status" do

#       end

#       it "returns an error object with a message describing bad request input" do

#       end
#     end

#     context "with valid param &older_than=2010_01_01" do
#       it "returns a question object that aired before param with all its relevant data" do

#       end
#     end

#     context "with invalid param &older_than=nineties" do
#       it "returns an error object with a 400 status" do

#       end

#       it "returns an error object with a message describing bad request input" do

#       end
#     end

#     context "with valid param range &newer_than=2010_01_01&older_than=2011_01_01" do
#       it "returns a question object that aired between param range with all its relevant data" do

#       end
#     end

#     context "with invalid param range &newer_than=2010_01_01&older_than=2009_01_01" do
#       it "returns an error object with a 400 status" do

#       end

#       it "returns an error object with a message describing bad request input; minimum is greater than maximum" do

#       end
#     end
#   end
end