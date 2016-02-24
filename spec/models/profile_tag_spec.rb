require 'rails_helper'

RSpec.describe ProfileTag, type: :model do
  it "creates basic profile tag" do
    expect(build(:profile_tag)).to be_valid
  end

  context "with validations" do
    it "requires profile" do
      expect(build(:profile_tag, :profile => nil)).not_to be_valid
    end

    it "requires tag" do
      expect(build(:profile_tag, :tag => nil)).not_to be_valid
    end
  end

end
