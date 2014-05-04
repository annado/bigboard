class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :recoverable,
         :rememberable, :trackable

  devise :omniauthable, :omniauth_providers => [:yammer]

  def self.find_for_yammer_oauth(auth)
    user = where(provider: auth[:provider], uid: "#{auth[:uid]}").first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
    end
    user.update({
      access_token: auth.credentials.token,
      name: auth.info.name,
      image: auth.info.image
    })
    user
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.yammer_data"] && session["devise.yammer_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end
end
