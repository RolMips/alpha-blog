# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update destroy]
  before_action :require_user, only: %i[edit update]
  before_action :require_same_user, only: %i[edit update destroy]

  def index
    @users = User.paginate(page: params[:page], per_page: 2)
  end

  def show
    @articles = @user.articles.paginate(page: params[:page], per_page: 2)
  end

  def new
    @user = User.new
  end

  def edit; end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:success] = 'Welcome to the alpha blog ! Your have succesfully sign up!'
      redirect_to articles_path
    else
      render :new
    end
  end

  def update
    if @user.update(user_params)
      flash[:success] = 'Your account was succesfully updated.'
      redirect_to @user
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    session[:user_id] = nil if @user == current_user
    flash[:success] = 'Your account and all your articles was succesfully deleted.'
    redirect_to articles_path
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def require_same_user
    return unless !current_user.admin? && current_user != @user

    flash[:danger] = 'You can only edit or delete your own account'
    redirect_to @user
  end
end
