class User < ActiveRecord::Base
  
  has_many :authentications, :dependent => :destroy
  
  has_many :submissions, :dependent => :destroy
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :username, :password, :password_confirmation, :remember_me
  
  validates :username, { :presence => true, 
                         :uniqueness => true }
                         ;
   def apply_omniauth(omniauth)
     self.username = omniauth['info']['nickname'] if username.blank?
     self.email = omniauth['info']['email'] if email.blank?
     authentications.build(:provider => omniauth['provider'], :uid => omniauth['uid'])
   end
   
   def password_required?
     (authentications.empty? || !password.blank?) && super
   end

   def total_goals
     total = 0
     self.submissions.each do |sub|
       total += sub.goals
     end
     self.goals = total
     self.save
     return total
   end
end
