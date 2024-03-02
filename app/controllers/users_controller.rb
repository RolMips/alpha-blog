class UsersController < ApplicationController

  before_action :set_user, only: [:edit, :update, :show]

def new
  @user = User.new
end

def create
  @user = User.new(user_params)
  if @user.save
      flash[:notice] = "Welcome to the alpha blog ! Your have succesfully sign up!"
      redirect_to articles_path
  else
      render :new
  end
end

def edit
end

def index
  @users = User.all
end

def show
  @articles = @user.articles
end

def update
  if @user.update(user_params)
    flash[:notice] = "Your account was succesfully updated."
    redirect_to @user
  else
    render :edit
  end
end

private

def user_params
    params.require(:user).permit(:username, :email, :password)
end

def set_user
  @user = User.find(params[:id])
end

end
