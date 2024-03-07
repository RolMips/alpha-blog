class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      flash[:success] = "Logged in successfully!"
      redirect_to root_path
    else
      flash[:danger] = "Invalid credentials!"
      redirect_to login_path
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = "Logged out successfully!"
    redirect_to root_path
  end

end
