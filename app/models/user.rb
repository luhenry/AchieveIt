class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :omniauthable, :trackable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :first_name, :last_name, :email

  has_many :achievements, :through => :user_achievements

  def self.find_for_facebook_oauth(auth, signed_in_resource = nil)
    user = User.find_or_create_by_provider_name_and_provider_uid('facebook', auth.uid) do |u|
      u.first_name = auth.info.first_name
      u.last_name  = auth.info.last_name
      u.email      = auth.info.email
    end

    user.provider_token = auth.credentials.token
    user.save

    return user
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"]
      end
    end
  end
end
