include Warden::Test::Helpers

module FeatureMacros
  def login
    before :each do
      user = create(:user)
      login_as user, scope: :user
      user
    end
  end
end
