# frozen_string_literal: true

class DebitTransaction < Transaction
  default_scope { where(transaction_type: [1, 3]) }

  belongs_to :wallet
  before_save :set_debit_type

  delegate :user, to: :wallet
  validates :amount, numericality: { greater_than: 0 }

  private

  def set_debit_type
    self.transaction_type ||= 1
  end
end
