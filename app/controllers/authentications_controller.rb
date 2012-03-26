class AuthenticationsController < ApplicationController
  # GET /authentications
  # GET /authentications.json
  def index
    @authentications = current_user.authentications if current_user

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @authentications }
    end
  end

  # GET /authentications/1
  # GET /authentications/1.json


  # POST /authentications
  # POST /authentications.json
  def create
    # @authentication = Authentication.new(params[:authentication])
    # 
    # respond_to do |format|
    #   if @authentication.save
    #     format.html { redirect_to @authentication, notice: 'Authentication was successfully created.' }
    #     format.json { render json: @authentication, status: :created, location: @authentication }
    #   else
    #     format.html { render action: "new" }
    #     format.json { render json: @authentication.errors, status: :unprocessable_entity }
    #   end
    # end
    
      omniauth = request.env["omniauth.auth"]
      session[:goals] = []
      authentication = Authentication.find_by_provider_and_uid(omniauth['provider'], omniauth['uid'])
      if authentication && authentication.user.present?
        flash[:notice] = "Signed in successfully."
        sign_in_and_redirect(:user, authentication.user)
      elsif current_user
        current_user.authentications.create!(:provider => omniauth['provider'], :uid => omniauth['uid'], :username => omniauth['info']['nickname'])
        flash[:notice] = "Authentication successful."
        redirect_to authentications_url
      else
        user = User.new
        user.apply_omniauth(omniauth)
        if user.save
          flash[:notice] = "Signed in successfully."
          sign_up_and_redirect(:user, user)
        else
          session[:omniauth] = omniauth.except('extra')
          redirect_to new_user_registration_url
        end
      end
  
  end


  # DELETE /authentications/1
  # DELETE /authentications/1.json
  def destroy
    @authentication = current_user.authentications.find(params[:id])
    @authentication.destroy
    flash[:notice] = "Successfully destroyed authentication."

    respond_to do |format|
      format.html { redirect_to authentications_url }
      format.json { head :no_content }
    end
  end
  
  def test
    @hash = request.env["omniauth.auth"]
  end
  
end
