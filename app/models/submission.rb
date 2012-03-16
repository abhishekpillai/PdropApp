class Submission < ActiveRecord::Base
  
  belongs_to :user
  
  validates :goals, :user_id, :presence => true

end
