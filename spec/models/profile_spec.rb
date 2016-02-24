require 'rails_helper'

RSpec.describe Profile, type: :model do
  it "creates basic profile" do
    expect(build(:profile)).to be_valid
  end

  context "with validations" do
    it "requires user" do
      expect(build(:profile, :user => nil)).not_to be_valid
    end
  end
end
