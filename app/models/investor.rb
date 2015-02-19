class Investor < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and 
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,:confirmable,:omniauthable


  def self.connect_to_linkedin(auth, signed_in_resource=nil)
    investor = Investor.where(:provider => auth.provider, :uid => auth.uid).first
    if investor
      return investor
    else
      registered_investor = Investor.where(:email => auth.info.email).first
      if registered_investor
        return registered_investor
      else
        investor = Investor.new(
                last_name:auth.info.last_name,
                user_name: auth.info.name,
                provider:auth.provider,
                uid:auth.uid,
                email:auth.info.email,
                password:Devise.friendly_token[0,20],
              )
        #investor.skip_confirmation!
        investor.save! 
        investor
      end
    end
  end   

  def self.connect_to_angellist(auth, signed_in_resource=nil)
    investor = Investor.where(:provider => auth.provider.to_s, :uid => auth.uid.to_s).first
    if investor
      return investor
    else
      registered_investor = Investor.where(:email => auth.info.email).first
      if registered_investor
        return registered_investor
      else
        investor = Investor.new(
                last_name:auth.info.last_name,
                user_name: auth.info.name,
                provider:auth.provider,
                uid:auth.uid,
                email:auth.info.email,
                password:Devise.friendly_token[0,20],
              )
        #investor.skip_confirmation!
        investor.save! 
        investor
      end
    end
  end   
end
