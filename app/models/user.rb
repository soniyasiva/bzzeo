class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_one :profile

  after_create do
    Profile.create(:user => self, name: email.match(/^[a-zA-Z]+/))
  end unless Rails.env.test?
end
