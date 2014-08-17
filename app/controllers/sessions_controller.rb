class SessionsController < ApplicationController
  def new
    redirect_to home_path if current_user
  end

  def create
    user = User.where(email: params[:email]).first

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      # flash[:notice] = "Welcome, you've signed in."
      redirect_to home_path, notice: "Welcome, you've signed in."
    else
      flash[:error] = "Invalid email and/or password."
      redirect_to sign_in_path
    end
  end

  def destroy
    session[:user_id] = nil
    # flash[:notice] = "You've signed out."
    redirect_to root_path, notice: "You've signed out."
  end
end