# frozen_string_literal: true

module Transactions
  class DepositService
    def initialize(user:, amount:)
      @user = user
      @user_wallet = @user.wallet
      @amount = amount.to_f
    end

    def perform
      check_for_amount
      deposit
    end

    private

    def check_for_amount
      return raise CustomErrors::AmountMustBePositive if @amount <= 0
    end

    def deposit
      ActiveRecord::Base.transaction do
        add_to_user
        create_debit_transaction
      end
    end

    def add_to_user
      @user_wallet.balance = @user.balance + @amount
      @user_wallet.save
    end

    def create_debit_transaction
      trx = @user_wallet.debit_transactions.new(debit_transaction_params)
      trx.save
    end

    def debit_transaction_params
      {
        transaction_type: 3,
        amount: @amount,
        status: 1
      }
    end
  end
end
