class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_one :profile, dependent: :destroy

  after_create do
    profile = Profile.new(:user => self, name: email.match(/^[a-zA-Z]+/).to_s.capitalize).save
    # profile.update_attribute(name: nil)
    # Profile.new(:user => self).save(:validate => false)
  end unless Rails.env.test?
end
