# frozen_string_literal: true

class PagesController < ApplicationController
  before_action :require_login, only: :dashboard

  def dashboard
    @balances = @current_user.wallet_balance
    @deposit  = Transaction.new
    @withdraw = Transaction.new
    @transfer = Transaction.new
  end

  def login
    redirect_to dashboard_path unless session[:user].nil?

    @user = User.new
  end

  def sessions
    session[:user_id] = Auth::LoginService.new(params: params[:user]).perform
    redirect_to dashboard_path, notice: 'Successfully logged in'
  rescue StandardError
    redirect_to login_path, alert: 'Invalid credentials'
  end

  def logout
    session[:user] = nil

    redirect_to login_path, notice: 'Sucessfully logged out'
  end
end
