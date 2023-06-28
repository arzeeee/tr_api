# frozen_string_literal: true

class UsersController < ApplicationController
  def new
    redirect_to root_path unless session[:user].nil?

    @user = User.new
  end

  def create
    @user = Auth::RegisterService.new(params: params[:user]).perform
    redirect_to login_path, notice: 'User was successfully created. Please log in'
  rescue CustomErrors::DuplicateUser
    redirect_to register_path, error: 'Username is already taken'
  end

  def index
    @users = User.all
  end
end
