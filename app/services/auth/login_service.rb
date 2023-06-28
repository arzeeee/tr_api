# frozen_string_literal: true

module Auth
  class LoginService
    def initialize(params:)
      @username = params[:username]
      @password = params[:password]
    end

    def perform
      authenticate_user
    end

    private

    def authenticate_user
      @user = User.find_by(username: @username)
      credential_error if @user.nil?

      credential_error unless check_password

      @user.id
    end

    def check_password
      @user.password == Digest::SHA2.hexdigest(@password)
    end

    def credential_error
      raise CustomErrors::InvalidCredentials
    end
  end
end
