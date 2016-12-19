class UsersController < ApplicationController

 wrap_parameters :user, include: [:username, :password, :password_confirmation]

    def new
      if logged_in?
        redirect_to root_path
      else
        @user = User.new
      end
    end
              #############################################################################
   def index
	if logged_in?
		if current_user.superuser == true
			@users = User.all
		else
			redirect_to root_path
 		end
	else
		redirect_to root_path
	end
  end

    def create
      captcha_message = "The data you entered for the CAPTCHA wasn't correct.  Please try again"
      @user = User.new(user_params)
       if !verify_recaptcha(model: @user, message: captcha_message) || !@user.save
            render "new"
       else
        UserMailer.account_activation(@user).deliver_now
         flash[:info] = "Please check your email to activate your account."
         redirect_to root_url
       end
    end

              #############################################################################


    def edit
      @user = User.find(params[:id])
	redirect_to root_path
    end
              #############################################################################


    def update
     @user = User.find(params[:id])
      if @user.update_attributes(user_params)
      # Handle a successful update.
        flash[:success] = "Profile updated"
        redirect_to @user
      else
        render 'edit'
      end
    end

	def show
		@user = User.find(params[:id])
	end
              #############################################################################


    def destroy
      User.find(params[:id]).destroy
      flash[:success] = "User deleted"
      redirect_to users_url
    end

              #############################################################################

    def json
      if logged_in?
        @search = params[:q]
        @users = User.where("username like ?", "%#{@search}%").where.not(id: current_user.id)
        @json = @users.to_json(:only => ["id" ,"username","firstname","lastname"])
        @json.gsub!('"username":','"name":')
        render :json => @json
      else
        render :json => "[]"
      end
    end

  private

    def user_params
      params.require(:user).permit(:username, :password, :password_confirmation ,:email, :firstname, :lastname, :school)
    end
end

