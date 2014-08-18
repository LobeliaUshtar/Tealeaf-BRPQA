class SessionsController < ApplicationController
  def new
    redirect_to home_path if current_user
  end

  def create
    user = User.where(email: params[:email]).first

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:success] = "Welcome, you've signed in."
      redirect_to home_path, success: "Welcome, you've signed in."
    else
      flash[:danger] = "Invalid email and/or password."
      redirect_to sign_in_path
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = "You've signed out."
    redirect_to root_path, success: "You've signed out."
  end
end