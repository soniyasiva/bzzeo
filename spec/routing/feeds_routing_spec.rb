require "rails_helper"

RSpec.describe FeedsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/feeds").to route_to("feeds#index")
    end

  end
end
