# frozen_string_literal: true

class UsersController < ApplicationController
  layout 'welcome'
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to '/games'
    else
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :password, :birth_date, :email)
  end
end
