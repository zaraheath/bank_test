module BankTest
  class Bank
    attr_reader :accounts, :transfers

    def initialize
      @accounts = []
      @transfers = []
    end

    def add_account(account)
      self.accounts << account
    end

    def add_transfer(transfer)
      self.transfers << transfer
    end

    def accounts_by_holder(holder)
      @accounts.select{|account| account.holder == holder}
    end

    def make_transfer(sender_account, receiver_account, amount)
      raise "Error::NotEnoughMoney" if sender_account.balance < amount

      if sender_account.bank == receiver_account.bank
        add_transfer(BankTest::IntraBankTransfer.new(sender_account, receiver_account, amount))
        sender_account.balance -= amount
        receiver_account.balance += amount
        true
      else
        success = receives_transfer
        inter_bank_transfer = BankTest::InterBankTransfer.new(sender_account, receiver_account, amount, success)
        add_transfer(inter_bank_transfer)
        raise "Error::NotEnoughMoney" if sender_account.balance < amount + inter_bank_transfer.commission
        if success
          sender_account.balance -= amount
          sender_account.balance -= inter_bank_transfer.commission
          receiver_account.balance += amount
          true
        else
          false
        end
      end

    end

    private

    def receives_transfer
      rand > 0.3
    end

  end
end