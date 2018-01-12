require 'rails_helper'

RSpec.describe "Api::V1::Companies", type: :request do
  describe "GET /api_v1_companies" do
    it "works! (now write some real specs)" do
      get api_v1_companies_path
      expect(response).to have_http_status(200)
    end
  end
end
