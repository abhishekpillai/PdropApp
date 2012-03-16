# require 'uri'

class Submission < ActiveRecord::Base
  
  belongs_to :user
  
  validates :title, :link, :presence => true
  
  validates :goals, :user_id, :presence => true
  
  # def source(link)
  #   return URI(link).host.sub(/^www\./,"")
  # end

end
