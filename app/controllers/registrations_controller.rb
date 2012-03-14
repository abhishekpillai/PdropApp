class RegistrationsController < Devise::RegistrationsController
  
  def create
    super
    session[:omniauth] = nil unless @user.new_record? 
  end
  
  private
  
  # Devise’s RegistrationsController class has a method called build_resource that builds a User model inside the new and create actions. By overriding this method we can add some custom behaviour to the user model that is created and add an associated authentication based on the information that we saved in the OmniAuth session variable.
  def build_resource(*args)
    super
    if session[:omniauth]
      @user.apply_omniauth(session[:omniauth])
      @user.valid?
    end
  end
  
  # CREATE: to remove the OmniAuth data from the session once the user has successfully registered. We can do that by overriding the create action.

end
