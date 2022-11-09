class SsoUser < User
  devise :cas_authenticatable, 
     :recoverable, :rememberable, :trackable
end