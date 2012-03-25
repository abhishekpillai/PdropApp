module SubmissionsHelper

  def timestamp(created_time)
  	time_in_seconds = Time.now - created_time

  	if time_in_seconds < 3601
  		return "#{(time_in_seconds/60).to_i} minutes"
  	elsif time_in_seconds < 86401	
  		return "#{(time_in_seconds/3600).to_i} hours"
  	else
  		return "#{(time_in_seconds/86400).to_i} days"
  	end
  end
end
