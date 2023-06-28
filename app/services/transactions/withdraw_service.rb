# frozen_string_literal: true

module Transactions
  class WithdrawService
    def initialize(user:, amount:)
      @user = user
      @user_wallet = @user.wallet
      @amount = amount.to_f
    end

    def perform
      check_for_amount
      check_for_balance
      withdraw
    end

    private

    def check_for_amount
      return raise CustomErrors::AmountMustBePositive if @amount <= 0
    end

    def check_for_balance
      return raise CustomErrors::BalanceNotEnough if (@user.balance - @amount).negative?
    end

    def withdraw
      ActiveRecord::Base.transaction do
        deduct_from_user
        create_credit_transaction
      end
    end

    def deduct_from_user
      @user_wallet.balance = @user.balance - @amount
      @user_wallet.save
    end

    def create_credit_transaction
      trx = @user_wallet.credit_transactions.new(credit_transaction_params)
      trx.save
    end

    def credit_transaction_params
      {
        transaction_type: 2,
        amount: @amount,
        status: 1
      }
    end
  end
end
