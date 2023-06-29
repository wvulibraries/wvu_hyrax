# frozen_string_literal: true
class User < ApplicationRecord
  # Connects this user object to Hydra behaviors.
  include Hydra::User
  # Connects this user object to Role-management behaviors.
  include Hydra::RoleManagement::UserRoles

  # Connects this user object to Hyrax behaviors.
  include Hyrax::User
  include Hyrax::UserUsageStats

  attr_accessible :email, :password, :password_confirmation if Blacklight::Utils.needs_attr_accessible?
  # Connects this user object to Blacklights Bookmarks.
  include Blacklight::User
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  # current setup for database authentication
  # devise :invitable, :database_authenticatable, :registerable,
  #        :recoverable, :rememberable, :trackable, :validatable

  include Devise::Models::DatabaseAuthenticatable

  # uncomment for cas setup
  devise :invitable, :cas_authenticatable, 
     :recoverable, :rememberable, :trackable

  # Method added by Blacklight; Blacklight uses #to_s on your
  # user class to get a user-displayable login/identifier for
  # the account.
  def to_s
    email
  end

  # Returns String containing First Name and Last Name
  # @return String
  # @author(s) David J. Davis, Tracy A. McCormick
  def name
    "#{first_name} #{last_name}"
  end  
end


# class User < ApplicationRecord
#   # Connects this user object to Hydra behaviors.
#   include Hydra::User

#   # Connects this user object to Role-management behaviors.
#   include Hydra::RoleManagement::UserRoles

#   # Connects this user object to Hyrax behaviors.
#   include Hyrax::User
#   include Hyrax::UserUsageStats

#   attr_accessible :email if Blacklight::Utils.needs_attr_accessible?

#   # Connects this user object to Blacklights Bookmarks.
#   include Blacklight::User

#   # Devise Authentication
#   # -----------------------------------------------------
#   # Include default devise modules. Others available are:
#   # :confirmable, :lockable, :timeoutable and :omniauthable
#   # devise :invitable, :cas_authenticatable, 
#   #    :recoverable, :rememberable, :trackable
         
#   devise :invitable, :database_authenticatable, :registerable,
#          :recoverable, :rememberable, :validatable

#   # Include default devise modules. Others available are:
#   # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
#   # devise :invitable, :database_authenticatable, :recoverable, :rememberable, :validatable, :trackable,
#   #        :omniauthable, omniauth_providers: [:cas]

#   # devise :invitable, :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable,
# 	#        :omniauthable, omniauth_providers: [:cas]

#   # Validations
#   # -----------------------------------------------------
#   validates :first_name, presence: true, length: { within: 2..70 }
#   validates :last_name, presence: true, length: { within: 2..70 }
#   validates :username, presence: true, length: { within: 2..70 }
#   # validates :email, presence: true
#   # validate  :valid_email

#   # Method added by Blacklight; Blacklight uses #to_s on your
#   # user class to get a user-displayable login/identifier for
#   # the account.
#   def to_s
#     email
#   end

#   # Returns String containing First Name and Last Name
#   # @return String
#   # @author(s) David J. Davis, Tracy A. McCormick
#   def name
#     "#{first_name} #{last_name}"
#   rescue StandardError
#     'Unknown User'
#   end

#   # def from_omniauth(auth)
#   #   if User.where(uid: auth.extra.uid).present?
#   #       user = User.find_by(uid: auth.extra.uid)
#   #   # Find a user if they were previously saved using email and password
#   #   elsif User.where(email: auth.extra.mail).present?
#   #       user = User.find_by(email: auth.extra.mail)
#   #   else
#   #       user = User.new
#   #   end
#   #   user.provider = auth.provider
#   #   user.uid = auth.extra.uid
#   #   # user.display_name = auth.extra.cn
#   #   user.email = auth.extra.mail
#   #   user.password = Devise.friendly_token[0,20]
#   #   user.save!
#   #   user
#   # end

#   # def self.new_with_session(params, session)
#   #   super.tap do |user|
#   #     if data = session['devise.cas_data'] && session['devise.cas_data']['extra']['raw_info']
#   #       user.email = data['email'] if user.email.blank?
#   #     end
#   #   end
#   # end

#   # def self.from_omniauth(auth)
#   #   where(uid: auth.uid).first_or_create do |user|
#   #     user.email = auth.info.email
#   #     user.password = Devise.friendly_token[0, 20]
#   #     user.first_name = auth.info.first_name
#   #     user.last_name = auth.info.last_name
#   #     # If you are using confirmable and the provider(s) you use validate emails,
#   #     # uncomment the line below to skip the confirmation emails.
#   #     user.skip_confirmation!
#   #   end
#   # end  

#   # def from_omniauth(auth)
#   #   where(email: auth.info.email).first do |user|
#   #     user.provider = auth.provider
#   #     user.uid = auth.uid
#   #     user.first_name = auth.info.first_name
#   #     user.last_name = auth.info.last_name
#   #     user.username = auth.info.username
#   #     user.email = auth.info.email
#   #     user.password = Devise.friendly_token[0,20]
#   #     user.save!
#   #   end
#   # end  

#   # def find_for_cas_oauth(access_token, signed_in_resource=nil)
#   #   data = access_token.extra.raw_info
#   #   logger.debug "DEBUG -> DATA #{data}"
#   #   if user = User.where(:username => data.username).first
#   #     user
#   #   else # Create a user with a stub password. 
#   #     User.create!(:email => data.email, :password => Devise.friendly_token[0,20]) 
#   #   end 
#   # end   
# end
