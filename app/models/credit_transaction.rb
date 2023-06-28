# frozen_string_literal: true

class CreditTransaction < Transaction
  default_scope { where(transaction_type: [0, 2]) }

  belongs_to :wallet
  before_save :set_credit_type

  delegate :user, to: :wallet
  validates :amount, numericality: { greater_than: 0 }

  private

  def set_credit_type
    self.tansaction_type ||= 0
  end
end
