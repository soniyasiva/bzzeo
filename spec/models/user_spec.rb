require 'rails_helper'

RSpec.describe User, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  describe "user creation" do
    it "creates a profile on user save" do
      user = create(:user)
      expect(user.profile).not_to be_nil
      expect(user.profile).to be_kind_of(Profile)
    end
  end
end
