module BankTest
  class Transfer
    attr_reader :sender, :receiver, :amount

    def initialize(sender, receiver, amount)
      @sender = sender
      @receiver = receiver
      @amount = amount
    end
  end
end