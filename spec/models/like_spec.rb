require 'rails_helper'

RSpec.describe Like, type: :model do
  it "creates basic like" do
    expect(build(:like)).to be_valid
  end

  context "with validations" do
    it "requires a profile" do
      expect(build(:like, :profile => nil)).not_to be_valid
    end

    it "requires a post" do
      expect(build(:like, :post => nil)).not_to be_valid
    end
  end
end
