require 'rails_helper'

RSpec.describe "Views", type: :request do
  describe "GET /views" do
    it "works! (now write some real specs)" do
      get views_path
      expect(response).to have_http_status(200)
    end
  end
end
