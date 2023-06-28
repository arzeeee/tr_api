# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include ApplicationHelper

  def require_login
    redirect_to login_path if session[:user_id].nil?

    @current_user = User.find_by(id: session[:user_id])
  end
end
