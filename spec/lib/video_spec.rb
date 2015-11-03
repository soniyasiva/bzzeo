require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the CategoriesHelper. For example:
#
# describe CategoriesHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end

include Video

describe "url manipulation" do
  context "from youtube" do
    it "extracts video id from share url" do
      expect(extract_video_id("https://youtu.be/HK0pBDZiWgk")).to eq("HK0pBDZiWgk")
    end

    it "extracts video id from normal url" do
      expect(extract_video_id("https://www.youtube.com/watch?v=HK0pBDZiWgk")).to eq("HK0pBDZiWgk")
    end

    it "extracts video id from polluted url" do
      expect(extract_video_id("https://www.youtube.com/watch?v=HK0pBDZiWgk&ok=nok")).to eq("HK0pBDZiWgk")
    end

    it "returns nil on bad url" do
      expect(extract_video_id("http://google.com/")).to eq(nil)
    end
  end

  context "from vimeo" do
    it "extracts video id from normal and share urls" do
      expect(extract_video_id("https://vimeo.com/143243001")).to eq("143243001")
    end

    it "extracts video id from polluted urls" do
      expect(extract_video_id("https://vimeo.com/143243001?ok=nok")).to eq("143243001")
    end
  end
end
