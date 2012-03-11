class Submission < ActiveRecord::Base
  belongs_to :user
  
  validates :goals, :presence => true
end
