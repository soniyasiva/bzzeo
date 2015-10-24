require 'rails_helper'

RSpec.describe Tag, type: :model do
  it "creates basic tag" do
    expect(build(:tag)).to be_valid
  end

  context "with validations" do
    it "requires name" do
      expect(build(:tag, :name => nil)).not_to be_valid
    end
  end
end
