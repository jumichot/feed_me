class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :trackable
  devise :omniauthable, :omniauth_providers => [:pocket]

  def self.find_for_pocket_oauth(auth)
    where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.pocket_username =  auth.extra.raw_info.username
      user.pocket_code =  auth.credentials.token
      user.save!
      user
    end
  end
end
