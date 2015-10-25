require 'rails_helper'

RSpec.describe Share, type: :model do
  it "creates basic share" do
    expect(build(:share)).to be_valid
  end

  context "with validations" do
    it "requires a post" do
      expect(build(:share, :post => nil)).not_to be_valid
    end

    it "requires a profile" do
      expect(build(:share, :profile => nil)).not_to be_valid
    end
  end

end
