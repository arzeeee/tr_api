# frozen_string_literal: true

class CustomErrors
  class InvalidCredentials < StandardError; end
  class DuplicateUser < StandardError; end
  class BalanceNotEnough < StandardError; end
  class UserNotFound < StandardError; end
  class AmountMustBePositive < StandardError; end
end
