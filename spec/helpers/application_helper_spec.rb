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
RSpec.describe ApplicationHelper, type: :helper do

  # helper vars
  vimeo_id = '143243001'
  youtube_id = 'HK0pBDZiWgk'

  describe "build video embed html" do
    it "builds from youtube" do
      expect(embed(youtube_id)).to eq('<iframe src="https://www.youtube.com/embed/HK0pBDZiWgk" frameborder="0" allowfullscreen></iframe>')
    end

    it "builds from vimeo" do
      expect(embed(vimeo_id)).to eq('<iframe src="https://player.vimeo.com/video/143243001?title=0&byline=0&portrait=0&badge=0" frameborder="0" webkitallowfullscreen mozallowfullscreen allowfullscreen></iframe>')
    end
  end

  describe "build video url" do
    it "builds youtube url" do
      expect(render_url(youtube_id)).to eq("https://youtu.be/#{youtube_id}")
    end

    it "builds vimeo url" do
      expect(render_url(vimeo_id)).to eq("https://vimeo.com/#{vimeo_id}")
    end
  end
end
