require 'rails_helper'

RSpec.describe Category, type: :request do
  describe "Endpoint: /categories.json" do
    it "Response contains a meta object describing pagination data" do
      get "/api/v1/categories.json"

      expect(response).to be_success

      expect(response_body_as_json).to have_key("meta")

      expect(response_body_as_json["meta"]).to \
        include("current_page", "next_page", "prev_page", "total_pages", "total_count")
    end

    context "without params" do
      it "returns 10 category objects on the first page in a `categories` array" do
        get "/api/v1/categories.json"

        expect(response).to be_success

        expect(response_body_as_json).to have_key("categories")

        expect(response_body_as_json["categories"].count).to eq(10)
      end
    end

    context "with valid param ?popular=5" do
      it "limits returned categories to 5 most popular sorted with most popular first" do
        get "/api/v1/categories.json?popular=5"

        expect(response).to be_success

        expect(response_body_as_json).to have_key("categories")

        expect(response_body_as_json["categories"].count).to eq(5)

        expect(response_body_as_json["categories"][0]["questions_count"]).to \
          be >= response_body_as_json["categories"][1]["questions_count"]
      end
    end

    context "with invalid param ?popular=X" do
      it "returns an error object with a 400 status" do
        get "/api/v1/categories.json?popular=X"

        expect(response_body_as_json).to have_key("error")

        expect(response_body_as_json["error"]["status"]).to eq("400")
      end

      it "returns an error object with a message describing bad request input" do
        get "/api/v1/categories.json?popular=X"

        expect(response_body_as_json["error"]["message"]).to match(/invalid count limit/)
      end
    end

    context "with valid param ?page=5" do
      it "returns results starting at page 5" do
        get "/api/v1/categories.json?page=5"

        expect(response).to be_success

        expect(response_body_as_json["meta"]["current_page"]).to eq(5)
      end
    end
  end

  describe "Endpoint: /categories/{id}.json" do
    context "with a valid ID" do
      it "returns a category object with all its relevant data" do
        get "/api/v1/categories/1.json"

        expect(response).to be_success

        expect(response_body_as_json).to have_key("category")

        expect(response_body_as_json["category"]).to \
          include("id", "name", "questions_count", "shows", "questions")

        expect(response_body_as_json["category"]["shows"]).to be_an(Array)

        expect(response_body_as_json["category"]["questions"]).to be_an(Array)
      end
    end

    context "with a valid ID but no matching record" do
      it "returns an error object with a 404 status" do
        invalid_id = Category.count + 1
        get "/api/v1/categories/#{invalid_id}.json"

        expect(response_body_as_json).to have_key("error")

        expect(response_body_as_json["error"]["status"]).to eq("404")
      end

      it "returns an error object with a message describing absence of matching record" do
        invalid_id = Category.count + 1
        get "/api/v1/categories/#{invalid_id}.json"

        expect(response_body_as_json["error"]["message"]).to match(/no category with ID/)
      end
    end

    context "with invalid ID" do
      it "returns an error object with a 400 status" do
        get "/api/v1/categories/X.json"

        expect(response_body_as_json).to have_key("error")

        expect(response_body_as_json["error"]["status"]).to eq("404")
      end

      it "returns an error object with a message describing bad request input" do
        get "/api/v1/categories/X.json"

        expect(response_body_as_json["error"]["message"]).to match(/no category with ID/)
      end
    end
  end
end