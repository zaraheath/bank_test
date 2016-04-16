module BankTest
  class TransferAgent
    def transfer(sender, receiver, amount)

      if sender.bank == receiver.bank
        sender.bank.make_transfer(sender, receiver, amount)
      else
        number_of_transfers = (amount.to_f / 1000).ceil
        raise "Error::NotEnoughMoney" if sender.balance < amount + BankTest::InterBankTransfer::COMMISSION * number_of_transfers
        successful_transfers = 0
        while(number_of_transfers > successful_transfers)
          partial_amount = amount >= 1000 ? 1000 : amount
          success = sender.bank.make_transfer(sender, receiver, partial_amount)
          if success
            successful_transfers += 1
            amount -= partial_amount
          end
        end
        true
      end
    end
  end
end