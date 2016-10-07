require 'rails_helper'

RSpec.describe Search, type: :request do
  describe "Endpoint: /searches/new.json?query=" do
    context "with query param" do
      it "returns matching categories and number of matches" do
        get "/api/v1/searches/new.json?query=duck"

        expect(response).to be_success

        expect(response_body_as_json).to include("category_count", "categories")

        expect(response_body_as_json["categories"]).to be_an(Array)

        expect(response_body_as_json["categories"]).to all satisfy { |result|
          result["name"].downcase =~ /duck/
        }
      end

      it "returns matching questions and number of matches" do
        get "/api/v1/searches/new.json?query=duck"

        expect(response).to be_success

        expect(response_body_as_json).to include("question_count", "questions")

        expect(response_body_as_json["questions"]).to be_an(Array)

        expect(response_body_as_json["questions"]).to all satisfy { |result|
          result["body"].downcase =~ /duck/ \
            || result["response"].downcase =~ /duck/ \
            || result["category"].downcase =~ /duck/
        }
      end
    end
  end
end