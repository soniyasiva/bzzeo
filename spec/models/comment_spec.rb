require 'rails_helper'

RSpec.describe Comment, type: :model do
  it "creates basic comment" do
    expect(build(:comment)).to be_valid
  end

  context "with validations" do
    it "requires a profile" do
      expect(build(:comment, :profile => nil)).not_to be_valid
    end

    it "requires a post" do
      expect(build(:comment, :post => nil)).not_to be_valid
    end

    it "requires a description not to be blank" do
      expect(build(:comment, :description => nil)).not_to be_valid
      expect(build(:comment, :description => "")).not_to be_valid
    end
  end

end
