# frozen_string_literal: true

class SessionsController < ApplicationController
  skip_before_action :authorized, only: %i[new create welcome]
  layout 'welcome'

  def new; end

  def login; end

  def welcome; end

  def create
    @user = User.find_by(username: params[:username])
    if @user&.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect_to '/games'
    else
      redirect_to '/login', notice: 'Username or password invalid'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to '/welcome'
  end
end
