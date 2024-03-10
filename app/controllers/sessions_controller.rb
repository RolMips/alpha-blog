# frozen_string_literal: true

class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if valid_user?(user, params[:session][:password])
      login_successful(user)
    else
      login_failed
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = 'Logged out successfully!'
    redirect_to root_path
  end

  private

  def valid_user?(user, password)
    user&.authenticate(password)
  end

  def login_successful(user)
    session[:user_id] = user.id
    flash[:success] = 'Logged in successfully!'
    redirect_to root_path
  end

  def login_failed
    flash[:danger] = 'Invalid credentials!'
    redirect_to login_path
  end
end
