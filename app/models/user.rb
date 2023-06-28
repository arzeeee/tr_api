# frozen_string_literal: true

class User < ApplicationRecord
  has_one :wallet, dependent: :destroy
  has_many :transactions, through: :wallet, dependent: :destroy
  has_many :credit_transactions, lambda {
                                   where(transaction_type: [0, 2])
                                 }, through: :wallet, class_name: 'Transaction', dependent: :destroy
  has_many :debit_transactions, lambda {
                                  where(transaction_type: [1, 3])
                                }, through: :wallet, class_name: 'Transaction', dependent: :destroy

  validates :username, :password, presence: true
  validates :username, uniqueness: true

  before_save :create_wallet

  def wallet_balance
    wallet.total_balance
  end

  delegate :balance, to: :wallet

  private

  def create_wallet
    build_wallet
  end
end
