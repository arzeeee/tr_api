# frozen_string_literal: true

class TransactionsController < ApplicationController
  before_action :require_login

  def index
    @transactions = @current_user.transactions
  end
end
