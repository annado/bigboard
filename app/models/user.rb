class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :recoverable,
         :rememberable, :trackable

  devise :omniauthable, :omniauth_providers => [:yammer]

  belongs_to :network

  def self.find_for_yammer_oauth(auth)
    network = Network.find_or_create_by(nid: auth.extra.raw_info.network_id,  name: auth.extra.raw_info.network_name)
    user = where(provider: auth[:provider], uid: "#{auth[:uid]}").first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.network = network
      user.permalink = auth.info.name
    end
    user.update({
      access_token: auth.credentials.token,
      #name: auth.info.name,
      image: auth.info.image,
      network: network,
      email: auth.info.email,
      permalink: auth.info.name
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
