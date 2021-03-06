class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    user_id = params[:id]
    @user = User.find_by(id: user_id)
    unless @user
      head :not_found
      return
    end
  end
  
  def login_form
    @user = User.new
  end

  def login
    username = params[:user][:username]
    user = User.find_by(username: username)
    
    if user 
      session[:user_id] = user.id
      flash[:success] = "Successfully logged in as returning user #{username}"
    elsif username.nil? || username == ""
      flash[:error] = "Invalid username."
      redirect_to login_path
      return
    else
      user = User.create(username: username)
      session[:user_id] = user.id
      flash[:success] = "Successfully logged in as new user #{username}"
    end
    redirect_to root_path
  end

  def logout
    session[:user_id] = nil
    flash[:success] = "Successfully logged out"
    redirect_to root_path
  end

end
