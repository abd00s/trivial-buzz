require 'rails_helper'

RSpec.describe Search, type: :request do
  describe "Endpoint: /search.json?query=" do
    context "with query param" do
      it "returns a meta object describing search results and pagination info" do
        get "/api/v1/search.json?query=duck"

        expect(response).to be_success

        expect(response_body_as_json).to have_key("meta")

        expect(response_body_as_json["meta"]).to \
          include("query", "current_page_category_count", "current_page_question_count", \
            "current_page", "next_page", "prev_page", "total_pages", "total_count")
      end

      it "returns a results array containing questions and categories matching search query" do
        get "/api/v1/search.json?query=duck"

        expect(response).to be_success

        expect(response_body_as_json).to have_key("results")

        expect(response_body_as_json["results"]).to be_an(Array)

        expect(response_body_as_json["results"]).to all satisfy { |result|
          if result["result_type"] == "question"
            result["body"].downcase =~ /duck/ \
              || result["response"].downcase =~ /duck/ \
              || result["category"].downcase =~ /duck/
          else
            result["name"].downcase =~ /duck/
          end
        }
      end
    end

    context "with a limiting param passed to [:only]" do
      it "returns only matching questions if param only=question" do
        get "/api/v1/search.json?query=duck&only=question"

        expect(response).to be_success

        expect(response_body_as_json["results"]).to all satisfy { |result|
          result["result_type"] == "question"
        }
      end

      it "returns only matching categories if param only=category" do
        get "/api/v1/search.json?query=duck&only=category"

        expect(response).to be_success

        expect(response_body_as_json["results"]).to all satisfy { |result|
          result["result_type"] == "category"
        }
      end

      it "returns an error object if limiting param is not recognized; only=responses" do
        get "/api/v1/search.json?query=duck&only=responses"

        expect(response_body_as_json).to have_key("error")

        expect(response_body_as_json["error"]["status"]).to eq("400")

        expect(response_body_as_json["error"]["message"]).to match(/not a valid filter/)
      end
    end
  end
end