class User < ActiveRecord::Base
  rolify
  #enum roles: [:member, :ground_owner, :admin]
 
  attr_accessor :role 
  after_create :set_role

  has_many :grounds
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable
  def self.find_for_facebook_oauth(auth, signed_in_resource=nil)
    user = User.where(:provider => auth.provider, :uid => auth.uid).first
    if user
      return user
    else
      registered_user = User.where(:email => auth.info.email).first
      if registered_user
        return registered_user
      else
        user = User.create(first_name: auth.extra.raw_info.first_name,
                            provider: auth.provider,
                            uid: auth.uid,
                            oauth_token: auth.credentials.token,
                            oauth_expires_at:  Time.at(auth.credentials.expires_at),
                            email:auth.info.email,
                            password:Devise.friendly_token[0,20],
                          )
      end    
    end
  end

  private
  
  def set_role
    binding.pry
    self.add_role role
  end
end
