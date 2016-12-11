class TeamsController < ApplicationController
  include TeamsHelper
  include UsersHelper

  before_action :set_team, only: [:show, :edit, :update, :destroy]

  # GET /teams
  # GET /teams.json
  def index
    @teams = Team.all
  end

  # GET /teams/1
  # GET /teams/1.json
  def show
  end

  # GET /teams/new
  def new
    @contest = Contest.find_by(id: params[:contest_id])
    @team = Team.new
    if @contest.nil?
    redirect_to contests_path
    else
      #if has_team_in_contest(current_user,@contest)
       # message = 'You have already a team.'
       # flash[:warning] = message
       # redirect_to @contest
      #end
      if not logged_in?
        message = "Please login before create a team."
          flash[:warning] = message
         redirect_to @contest
      else
      end
    end
  end

  # GET /teams/1/edit
  def edit
  end

  # POST /teams
  # POST /teams.json
  def create
    @members = team_params[:member].split(',')
    #team_params = team_params.delete(:member)
    params[:team].delete :member
    @team = Team.new(team_params)
    @contest = Contest.find_by(id: params[:contest_id])
    @team.users << current_user
    @team.contest = @contest

      if @team.save
         message = 'Team was successfully created.'
        flash[:success] = message

      @members.each do |member|
          @user = User.find_by(id: member)
          UserMailer.teamjoin(@user,@team).deliver_now if not @user.nil?
      end
        redirect_to contest_teams_path
      else
        render :new
      end
  end

  def join
    if not logged_in?
      message = 'Please login before.'
        flash[:info] = message
      redirect_to login_path
    end
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
          end
      end
    else
        message = 'Invalid token.'
        flash[:danger] = message
      redirect_to contests_path
    end

  end
  # PATCH/PUT /teams/1
  # PATCH/PUT /teams/1.json
  def update
      if @team.update(team_params)
        message = 'Team was successfully updated.'
        flash[:success] = message
        redirect_to contest_teams_path
      else
        render :edit
      end
  end

  # DELETE /teams/1
  # DELETE /teams/1.json
  def destroy
    @team.destroy
     redirect_to contest_teams_path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_team
      @team = Team.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def team_params
      params.require(:team).permit(:name, :member)
    end
end
