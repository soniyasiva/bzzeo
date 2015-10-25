require 'rails_helper'

RSpec.describe Post, type: :model do
  it "creates basic post" do
    expect(build(:post)).to be_valid
  end

  context "with validations" do
    it "requires a profile" do
      expect(build(:post, :profile => nil)).not_to be_valid
    end

    it "requires some form of content" do
      expect(build(:post, :image_url => nil, :video_url => nil, :description => nil)).not_to be_valid
    end

    it "requires can only have video or image" do
      expect(build(:post, :image_url => "http://placehold.it/600x400", :video_url => "https://www.youtube.com/watch?v=-9dAhOsyXBk")).not_to be_valid
    end
  end
end
