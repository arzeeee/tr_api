# frozen_string_literal: true

class Transaction < ApplicationRecord
  belongs_to :wallet
  before_save :set_transaction_date, :set_status

  scope :credit_transactions, -> { where(transaction_type: [0, 2]) }
  scope :debit_transactions, -> { where(transaction_type: [1, 3]) }

  enum transaction_type: { credit: 0, debit: 1, withdraw: 2, deposit: 3 }
  enum status: { waiting_for_payment: 0, paid: 1, cancelled: 2, error: 3, refunded: 4, done: 5 }

  validates :amount, numericality: { greater_than: 0 }

  def set_transaction_date
    self.transaction_date = Time.zone.today
  end

  def set_status
    self.status ||= 0
  end
end
