# frozen_string_literal: true

class Wallet < ApplicationRecord
  has_many :transactions
  has_many :credit_transactions, -> { where(transaction_type: [0, 2]) }, class_name: 'Transaction', dependent: :destroy
  has_many :debit_transactions, -> { where(transaction_type: [1, 3]) }, class_name: 'Transaction', dependent: :destroy
  belongs_to :user

  before_create :set_default_credit

  def credit_balance
    credit_transactions.sum(:amount)
  end

  def debit_balance
    debit_transactions.sum(:amount)
  end

  def total_balance
    {
      debit: debit_balance,
      credit: credit_balance,
      total: debit_balance - credit_balance + 50_000 # default credit value
    }
  end

  def set_default_credit
    self.balance = 50_000
  end
end
