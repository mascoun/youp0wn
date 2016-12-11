class SessionsController < ApplicationController

  def new
    user = User.new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      if user.activated?
        log_in user
        params[:session][:remember_me] == '1' ? remember(user) : forget(user)
        redirect_back_or user
      else
        message  = "Account not activated. "
        message += "Check your email for the activation link."
        flash[:warning] = message
        render :new
      end
    else
      flash.now[:danger] = 'Invalid email/password combination'
       render :new
    end
  end

  def destroy
    log_out if logged_in?
     render :new
  end



  def failure
    render :text => "Sorry, but you didn't allow access to our app!"
  end

  protected




end
