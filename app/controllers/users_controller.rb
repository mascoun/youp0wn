class UsersController < InheritedResources::Base

 wrap_parameters :user, include: [:username, :password, :password_confirmation]

    def new
        @user = User.new
    end
              #############################################################################


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

