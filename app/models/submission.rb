# require 'uri'

class Submission < ActiveRecord::Base
  
  belongs_to :user
  
  validates :title, :link, :presence => true
  
  validates :goals, :user_id, :presence => true
  
  def source(link)
    if link.starts_with?("http://")
      link.split('/')[2]
    elsif link.starts_with?("www.")
      link.split('.')[1]+'.'+link.split('.')[2]
    else
      link.split('/')[0]
    end
  end

end
