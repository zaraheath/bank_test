module BankTest
  class Account
    attr_reader :holder, :bank
    attr_accessor :balance

    def initialize(balance, holder, bank)
      @balance = balance
      @holder = holder
      @bank = bank
    end
  end
end