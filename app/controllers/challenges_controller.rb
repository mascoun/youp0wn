class ChallengesController < ApplicationController

  include UsersHelper

  def index
    if logged_in? and current_user.superuser
      @challenges = Challenge.all
    else
      flash[:danger] = "You are not allowed to access to this page"
      redirect_to root_path
  end
end

  def show
    @challenge = Challenge.find_by(id: params[:id])
    @contest = Contest.find_by(id: params[:contest_id])
    if not logged_in?
      redirect_to @contest
    else
      if not has_team_in_contest(current_user,@contest)
       redirect_to @contest
      else
        if Time.now < @contest.begins
            flash[:notice] = "Contest haven't start yet."
            redirect_to contest_path(@contest)
        else
          if team_user(current_user,@contest).challenges_ids.include? @challenge.id
            flash[:warning] = "You have already taken that challenge."
            redirect_to contest_path(@contest)
          end
          @challengeTest = Challenge.new
        end
      end
    end
  end

  def new
    if logged_in? and current_user.superuser
      @challenge = Challenge.new
    else
      flash[:danger] = "You are not allowed to access to this page"
      redirect_to root_path
    end
  end

  def flag
    if logged_in?
      @challenge = Challenge.find_by(id: params[:challenge_id])
      @contest = Contest.find_by(id: params[:contest_id])
      @Team = team_user(current_user,@contest)
      if Time.now > @contest.ends or Time.now < @contest.begins
          flash[:notice] = "Contest disabled!"
          redirect_to contest_path(@contest)
      else
        if(@challenge.flag == challenge_params[:flag])
          @Team.score += @challenge.score
          @Team.challenges_ids.push(@challenge.id)
          @Team.save
          redirect_to contest_path(@contest)
        else
          @Team.fault += 1
          @Team.save
          message  = "Wrong Flag. "
          flash[:danger] = message
          redirect_to contest_challenge_path(@contest,@challenge)
        end
      end
    else
      message  = "Login First!"
      flash[:danger] = message
      redirect_to root_path
    end
  end
  def download
   @challenge = Challenge.find_by(id: params[:challenge_id])
   extension= @challenge.attachement.split('.')
	send_file Rails.root.join('public','upload',@challenge.attachement),:type=>"application/#{extension[1]}", :x_sendfile=>true
	
end
  def create
    @contest = Contest.find_by(id: challenge_params[:contest_id])
    @category = Category.find_by(id: challenge_params[:category_id])
    @challenge = Challenge.new(challenge_params)
    uploaded_io=params[:challenge][:attachement]
    File.open(Rails.root.join('public','upload',uploaded_io.original_filename),'wb')do |file|
    file.write(uploaded_io.read)
    end
    @challenge.attachement=uploaded_io.original_filename 
    @challenge.contests << @contest
    @challenge.category = @category
    @contest.challenges << @challenge
    @category.challenges << @challenge
    #@challenge.contest = @contest
    #@challenge.contest_id = @contest.id
    #@challenge = @contest.challenges.build(challenge_params)
        respond_to do |format|
          if @challenge.save
            format.html { redirect_to contest_challenge_path(@contest,@challenge), notice: 'Challenge was successfully created.' }
            format.json { render :show, status: :created, location: @challenge }
          else
            format.html { render :new }
            format.json { render json: @challenge.errors, status: :unprocessable_entity }
          end
        end
  end


  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def challenge_params
      params.require(:challenge).permit(:name, :description, :flag, :attachement, :score, :contest_id, :category_id)
    end
end
