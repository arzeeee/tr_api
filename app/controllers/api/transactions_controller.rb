# frozen_string_literal: true

module Api
  class TransactionsController < ApplicationController
    before_action :require_login

    def withdraw
      respond_to do |format|
        Transactions::WithdrawService.new(user: @current_user, amount: params[:amount]).perform
        format.html { redirect_to root_path, notice: 'Withdraw Success' }
        format.json { render json: { status: 200, notice: 'Withdraw Success' }, status: :ok }
      rescue CustomErrors::BalanceNotEnough
        format.html { redirect_to root_path, alert: 'Balance Not Enough' }
        format.json { render json: { status: 200, alert: 'Balance Not Enough' }, status: :ok }
      rescue CustomErrors::AmountMustBePositive
        format.html { redirect_to root_path, alert: 'Amount must be greater than 0' }
        format.json { render json: { status: 200, alert: 'Amount must be greater than 0' }, status: :ok }
      end
    end

    def deposit
      respond_to do |format|
        Transactions::DepositService.new(user: @current_user, amount: params[:amount]).perform
        format.html { redirect_to root_path, notice: 'Deposit Success' }
        format.json { render json: { status: 200, notice: 'Deposit Success' }, status: :ok }
      rescue CustomErrors::AmountMustBePositive
        format.html { redirect_to root_path, alert: 'Amount must be greater than 0' }
        format.json { render json: { status: 200, alert: 'Amount must be greater than 0' }, status: :ok }
      end
    end

    def transfer
      respond_to do |format|
        Transactions::TransferService.new(user: @current_user, amount: params[:amount],
                                          username: params[:username]).perform
        format.html { redirect_to root_path, notice: 'Transfer Success' }
        format.json { render json: { status: 200, notice: 'Transfer Success' }, status: :ok }
      rescue CustomErrors::UserNotFound
        format.html { redirect_to root_path, alert: 'Username Not Found' }
        format.json { render json: { status: 200, alert: 'Username Not Found' }, status: :ok }
      rescue CustomErrors::BalanceNotEnough
        format.html { redirect_to root_path, alert: 'Balance Not Enough' }
        format.json { render json: { status: 200, alert: 'Balance Not Enough' }, status: :ok }
      rescue CustomErrors::AmountMustBePositive
        format.html { redirect_to root_path, alert: 'Amount must be greater than 0' }
        format.json { render json: { status: 200, alert: 'Amount must be greater than 0' }, status: :ok }
      end
    end
  end
end
