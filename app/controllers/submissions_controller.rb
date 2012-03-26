class SubmissionsController < ApplicationController
  
  before_filter :authenticate_user!, :except => [:show, :index, :leaderboard]
  
  def admin_dashboard
    @submissions = Submission.where("flag = ?", true).order("created_at desc").page(params[:page]).per(10)
  end
  
  def flag
    @submission = Submission.find_by_id(params[:id])
    @submission.flag = true
    @submission.save
    redirect_to submissions_url, :notice => "The submission was flagged. Thank you for letting us know!"    
  end
  
  def unflag
    @submission = Submission.find_by_id(params[:id])
    @submission.flag = false
    @submission.save
    redirect_to "/submissions/admin"
  end
  
  def leaderboard
    @top_users = User.order("goals desc").page(params[:page]).per(10)
    respond_to do |format|
      format.html # leaderboard.html.erb
      format.json { render json: @top_users }
    end
  end

# the 'goals' method adds handles the user voting up action
  def goals
    @submission = Submission.find(params[:id])
    if current_user.id == @submission.user.id
    
    else
      @submission.goals += 1
    end
    @submission.save
    session[:goals] << @submission.id.to_s
    respond_to do |format|
      format.js
      format.html { redirect_to '/submissions'}
      format.json { render json: @submissions }
    end
  end
  
  # GET /submissions
  # GET /submissions.json
  def index
    if !session[:goals].present?
      session[:goals] = []
    end
    
    @submissions = Submission.order("goals desc").page(params[:page]).per(9)
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @submissions }
    end
  end

  # GET /submissions/1
  # GET /submissions/1.json
  def show
    @submission = Submission.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @submission }
    end
  end

  # GET /submissions/new
  # GET /submissions/new.json
  def new
    @submission = Submission.new
    @submission.user = current_user
    
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @submission }
    end
  end

  # GET /submissions/1/edit
  def edit
    @submission = Submission.find(params[:id])
  end

  # POST /submissions
  # POST /submissions.json
  def create
    @submission = Submission.new(params[:submission])
    @submission.goals = 1
    
    check_http = @submission.link.split("www")
    if check_http[0] == "http://"
    else
      @submission.link = "http://" + @submission.link
    end
    
    respond_to do |format|
      if @submission.save
        format.html { redirect_to root_url, notice: 'Nice goal!' }
        format.json { render json: @submission, status: :created, location: @submission }
      else
        format.html { render action: "new" }
        format.json { render json: @submission.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /submissions/1
  # PUT /submissions/1.json
  def update
    @submission = Submission.find(params[:id])

    respond_to do |format|
      if @submission.update_attributes(params[:submission])
        format.html { redirect_to @submission, notice: 'Submission was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @submission.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /submissions/1
  # DELETE /submissions/1.json
  def destroy
    @submission = Submission.find(params[:id])
    @submission.destroy

    respond_to do |format|
      format.html { redirect_to submissions_url }
      format.json { head :no_content }
    end
  end
end
