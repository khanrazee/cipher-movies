class SessionsController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.where(email: params[:user][:email]).first
    if @user.present? && @user.valid_password?(params[:user][:password])
      sign_in @user
      return redirect_to search_users_path
    else
      flash[:error] = "Email or Password do not match."
    end
    redirect_to session_path
  end

  def destroy
    reset_sessions
    redirect_to :root
  end

end