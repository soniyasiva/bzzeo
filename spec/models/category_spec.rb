require 'rails_helper'

RSpec.describe Category, type: :model do
  it "creates basic category" do
    expect(build(:category)).to be_valid
  end

  context "with validations" do
    it "requires name" do
      expect(build(:category, :name => nil)).not_to be_valid
    end
  end
end
