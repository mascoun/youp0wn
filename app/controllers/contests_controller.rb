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
        if not logged_in?
            flash[:info] = "Please login before to join contest!"
            redirect_to login_path
        else
            @contest = Contest.find_by(id: params[:id])
	    @teams = Team.all.order(score: :desc).order(fault: :asc)
        end
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

