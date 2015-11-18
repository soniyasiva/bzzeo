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

describe Video do

  # helper vars
  vimeo_id = '143243001'
  youtube_id = 'HK0pBDZiWgk'

  describe "url manipulation" do
    context "from youtube" do
      it "extracts video id from share url" do
        expect(extract_video_id("https://youtu.be/#{youtube_id}")).to eq(youtube_id)
      end

      it "extracts video id from normal url" do
        expect(extract_video_id("https://www.youtube.com/watch?v=#{youtube_id}")).to eq(youtube_id)
      end

      it "extracts video id from polluted url" do
        expect(extract_video_id("https://www.youtube.com/watch?v=#{youtube_id}&ok=nok")).to eq(youtube_id)
      end

      it "returns nil on bad url" do
        expect(extract_video_id("http://google.com/")).to eq(nil)
      end
    end

    context "from vimeo" do
      it "extracts video id from normal and share urls" do
        expect(extract_video_id("https://vimeo.com/#{vimeo_id}")).to eq(vimeo_id)
      end

      it "extracts video id from polluted urls" do
        expect(extract_video_id("https://vimeo.com/#{vimeo_id}?ok=nok")).to eq(vimeo_id)
      end
    end
  end

  describe "video platform" do
    it "returns youtube platform" do
      expect(video_platform? youtube_id).to eq('youtube')
    end

    it "returns vimeo platform" do
      expect(video_platform? vimeo_id).to eq('vimeo')
    end

    it "returns no platform" do
      expect(video_platform? "").to be_nil
    end
  end

  describe "thumbnails" do
    it "gets youtube thumbnail" do
      expect(get_thumbnail(youtube_id)).to eq("https://img.youtube.com/vi/#{youtube_id}/mqdefault.jpg")
    end

    it "gets vimeo thumbnail" do
      expect(get_thumbnail(vimeo_id)).to eq("https://i.vimeocdn.com/video/540773028_640.jpg")
    end
  end

end
