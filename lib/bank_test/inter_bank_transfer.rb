require 'bank_test/transfer'
module BankTest
  class InterBankTransfer < Transfer
    COMMISSION = 5
    attr_reader :commission, :received

    def initialize(sender, receiver, amount, received)
      raise "Error::NotValidAmount" if amount > 1000
      super sender, receiver, amount
      @commission = COMMISSION
      @amount = amount
      @received = received
    end

  end
end