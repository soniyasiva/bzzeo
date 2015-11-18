require 'rails_helper'

RSpec.describe "PostCategories", type: :request do
  describe "GET /post_categories" do
    it "works! (now write some real specs)" do
      get post_categories_path
      expect(response).to have_http_status(200)
    end
  end
end
