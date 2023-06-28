# frozen_string_literal: true

module Transactions
  class TransferService
    def initialize(user:, amount:, username:)
      initialize_sender_and_receiver(user, username)
      @amount = amount.to_f
    end

    def perform
      check_for_amount
      check_for_receiver
      check_for_balance
      transfer
    end

    private

    def initialize_sender_and_receiver(user, username)
      @sender = user
      @sender_wallet = @sender.wallet
      @receiver = User.find_by(username: username)
      @receiver_wallet = @receiver&.wallet
    end

    def check_for_amount
      return raise CustomErrors::AmountMustBePositive if @amount <= 0
    end

    def check_for_balance
      raise CustomErrors::BalanceNotEnough if (@sender.balance - @amount).negative?
    end

    def check_for_receiver
      raise CustomErrors::UserNotFound if @receiver.nil?
    end

    def transfer
      ActiveRecord::Base.transaction do
        add_to_receiver
        deduct_from_sender
        create_credit_transaction
        create_debit_transaction
      end
    end

    def add_to_receiver
      @receiver_wallet.balance = @receiver_wallet.balance + @amount
      @receiver_wallet.save
    end

    def deduct_from_sender
      @sender_wallet.balance = @sender_wallet.balance - @amount
      @sender_wallet.save
    end

    def create_debit_transaction
      trx = @receiver_wallet.debit_transactions.new(debit_transaction_params)
      trx.save
    end

    def create_credit_transaction
      trx = @sender_wallet.credit_transactions.new(credit_transaction_params)
      trx.save
    end

    def credit_transaction_params
      {
        transaction_type: 0,
        amount: @amount,
        status: 1
      }
    end

    def debit_transaction_params
      {
        transaction_type: 1,
        amount: @amount,
        status: 1
      }
    end
  end
end
