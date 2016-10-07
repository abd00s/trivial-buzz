require 'rails_helper'

RSpec.describe Round, type: :request do
  describe "Endpoint: /rounds/{id}.json" do
    context "with a valid ID" do
      it "returns a round object with all its relevant data" do
        round_id = Round.first.id
        get "/api/v1/rounds/#{round_id}.json"

        expect(response).to be_success

        expect(response_body_as_json).to have_key("round")

        expect(response_body_as_json["round"]).to \
          include("id", "name", "from_show", "categories", "questions")

        expect(response_body_as_json["round"]["from_show"]).to be_a(Hash)

        expect(response_body_as_json["round"]["categories"]).to be_an(Array)

        expect(response_body_as_json["round"]["questions"]).to be_an(Array)
      end
    end

    context "with a valid ID but no matching record" do
      it "returns an error object with a 404 status" do
        invalid_id = Round.count + 1
        get "/api/v1/rounds/#{invalid_id}.json"

        expect(response_body_as_json).to have_key("error")

        expect(response_body_as_json["error"]["status"]).to eq("404")
      end

      it "returns an error object with a message describing absence of matching record" do
        invalid_id = Round.count + 1
        get "/api/v1/rounds/#{invalid_id}.json"

        expect(response_body_as_json["error"]["message"]).to match(/no round with ID/)
      end
    end

    context "with an invalid ID" do
      it "returns an error object with a 400 status" do
        get "/api/v1/rounds/X.json"

        expect(response_body_as_json).to have_key("error")

        expect(response_body_as_json["error"]["status"]).to eq("404")
      end

      it "returns an error object with a message describing bad request input" do
        get "/api/v1/rounds/X.json"

        expect(response_body_as_json["error"]["message"]).to match(/no round with ID/)
      end
    end
  end
end