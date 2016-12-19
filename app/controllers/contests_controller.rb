class ContestsController < ApplicationController
    require 'date'
    include UsersHelper

    def new
      if logged_in? and current_user.superuser
        @contest = Contest.new
      else
        flash[:danger] = "You are not allowed to access to this page"
        redirect_to root_path
      end
    end

    def show
            @contest = Contest.find_by(id: params[:id])
	    @teams = @contest.teams.order(score: :desc).order(fault: :asc)
    end
    def index
 	@contests = Contest.all
    end
    def create
        contest_params[:begins] = DateTime.parse(contest_params[:begins])
        contest_params[:ends] = DateTime.parse(contest_params[:ends])
        @contest = Contest.new(contest_params)
       # @contest.photo = contest_params[:photo].read
        @contest.photo = params[:contest][:photo].read
       if !@contest.save
            render "new"
       else
         flash[:success] = "Contest created !"
         redirect_to contests_url
       end
    end


   def update
        contest_params[:begins] = DateTime.parse(contest_params[:begins]) if contest_params[:begins] != ""
        contest_params[:ends] = DateTime.parse(contest_params[:ends]) if contest_params[:ends] != ""
        @contest = Contest.find_by(id: params[:id])
	@contest.name = contest_params[:name]
	@contest.description = contest_params[:description]
       # @contest.photo = contest_params[:photo].read
        @contest.photo = params[:contest][:photo].read
       if !@contest.save
            render "new"
       else
         flash[:success] = "Contest created !"
         redirect_to contests_url
       end
    end

    def edit 
      if logged_in? and current_user.superuser == true
	@contest = Contest.find_by(id: params[:id])
      else
	flash[:danger] = "You're not allowed to access to this page"
	redirect_to root_path
      end
    end
    def image
        @contest = Contest.find_by(id: params[:contest_id])
        filename = @contest.name.gsub(' ', '_')
        filename += ".jpg"
        send_data @contest.photo, filename: filename
    end
  private

    def contest_params
      params.require(:contest).permit(:name, :description,:begins ,:ends, :photo)
    end
end

