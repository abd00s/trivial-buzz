require 'rails_helper'

RSpec.describe Show, type: :request do
  describe "Endpoint: /shows.json" do
    it "Response contains a meta object describing pagination data" do
      get "/api/v1/shows.json"

      expect(response).to be_success

      expect(response_body_as_json).to have_key("meta")

      expect(response_body_as_json["meta"]).to \
        include("current_page", "next_page", "prev_page", "total_pages", "total_count")
    end

    context "without params" do
      it "returns 3 show objects on the first page" do
        get "/api/v1/shows.json"

        expect(response).to be_success

        expect(response_body_as_json).to have_key("shows")

        expect(response_body_as_json["shows"].count).to eq(3)
      end
    end

    context "with valid param ?chrono_sort=old" do
      it "returns show objects in ascending chronological order (oldest first)" do
        get "/api/v1/shows.json?chrono_sort=old"

        expect(response).to be_success

        expect(response_body_as_json["shows"][0]["air_date"]).to \
          be < response_body_as_json["shows"][1]["air_date"]
      end
    end

    context "with valid param ?chrono_sort=recent" do
      it "returns show objects in descending chronological order (recent first)" do
        get "/api/v1/shows.json?chrono_sort=recent"

        expect(response).to be_success

        expect(response_body_as_json["shows"][0]["air_date"]).to \
          be > response_body_as_json["shows"][1]["air_date"]
      end
    end

    context "with invalid param ?popular=newest" do
      it "returns an error object with a 400 status" do
        get "/api/v1/shows.json?chrono_sort=newest"

        expect(response_body_as_json).to have_key("error")

        expect(response_body_as_json["error"]["status"]).to eq("400")
      end

      it "returns an error object with a message describing bad request input" do
        get "/api/v1/shows.json?chrono_sort=newest"

        expect(response_body_as_json["error"]["message"]).to match(/Invalid sorting order/)
      end
    end
  end

  describe "Endpoint: /shows/{id}.json" do
    context "with a valid ID" do
      it "returns a show object with all its relevant data" do
        show_id = Show.first.id
        get "/api/v1/shows/#{show_id}.json"

        expect(response).to be_success

        expect(response_body_as_json).to have_key("show")

        expect(response_body_as_json["show"]).to \
          include("id", "show_number", "air_date", "categories", "rounds")

        expect(response_body_as_json["show"]["categories"]).to be_an(Array)

        expect(response_body_as_json["show"]["rounds"]).to be_an(Array)
      end
    end

    context "with a valid ID but no matching record" do
      it "returns an error object with a 404 status" do
        invalid_id = Show.count + 1
        get "/api/v1/shows/#{invalid_id}.json"

        expect(response_body_as_json).to have_key("error")

        expect(response_body_as_json["error"]["status"]).to eq("404")
      end

      it "returns an error object with a message describing absence of matching record" do
        invalid_id = Show.count + 1
        get "/api/v1/shows/#{invalid_id}.json"

        expect(response_body_as_json["error"]["message"]).to match(/no show with ID/)
      end
    end
  end
end