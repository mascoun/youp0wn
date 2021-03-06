class TeamsController < ApplicationController
  include TeamsHelper
  include UsersHelper

  before_action :set_team, only: [:show, :edit, :update, :destroy]

  # GET /teams
  # GET /teams.json
  def index
    #@teams = Team.all.order(score: :desc).order(fault: :asc)
    @contest = Contest.find_by(id: params[:contest_id])
    @teams = @contest.teams.order(score: :desc).order(fault: :asc)
  end


  def show
  end

  # GET /teams/new
  def new
    @contest = Contest.find_by(id: params[:contest_id])
    @team = Team.new
    if @contest.nil?
    redirect_to contests_path
    else
      if not logged_in?
        message = "Please login before create a team."
          flash[:warning] = message
         redirect_to @contest
      elsif @contest.open == false and current_user.superuser == false
	message = 'Contest isn\'t open. Contact an administrator to join a team'
        flash[:danger] = message
        redirect_to @contest
      elsif has_team_in_contest(current_user,@contest)
        message = 'You have already a team.'
        flash[:warning] = message
        redirect_to @contest
      end
    end
  end

  def edit
  end

  def create
    @contest = Contest.find_by(id: params[:contest_id])
    if @contest.open == true or current_user.superuser == true
  	@members = team_params[:member].split(',')
	#team_params = team_params.delete(:member)
	params[:team].delete :member	
	
      	@team = Team.new(team_params)
    if @contest.open == true
    	@team.users << current_user
    end
    @team.contest = @contest
     if @members.count >= @contest.team_user_number
	message = 'You have already a team.'
        flash[:warning] = message
        redirect_to @contest
     else
     	 if @team.save
	        message = 'Team was successfully created.'
	        flash[:success] = message
     		@members.each do |member|
		  @user = User.find_by(id: member)
		  UserMailer.teamjoin(@user,@team).deliver_now if not @user.nil?
         	end
         	redirect_to contest_teams_path
     	 end
     end
   else
        message = 'You cannot add a team.'
	flash[:danger] = message
        redirect_to contest_path
   end
end

  def join
    if not logged_in?
      message = 'Please login before.'
        flash[:info] = message
      redirect_to login_path
    else
    @team = Team.find_by(id: params[:team_id])
    if @team.join_digest == params[:token]
      if has_team_in_contest(current_user,@team.contest)
        message = 'You have already a team.'
        flash[:warning] = message
        redirect_to @team.contest
      else
         @team.users << current_user
          if @team.save
            message = 'You have successfully joined the team.'
            flash[:success] = message
            redirect_to contest_path(@team.contest)
          end
      end
    else
        message = 'Invalid token.'
        flash[:danger] = message
      redirect_to contests_path
    end
    end
  end


  def update
      if @team.update(team_params)
        message = 'Team was successfully updated.'
        flash[:success] = message
        redirect_to contest_teams_path
      else
        render :edit
      end
  end


  def destroy
    @team.destroy
     redirect_to contest_teams_path
  end

  private
    def set_team
      @team = Team.find(params[:id])
    end

    def team_params
      params.require(:team).permit(:name, :member)
    end
end

