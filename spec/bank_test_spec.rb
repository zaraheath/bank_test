require 'spec_helper'

describe BankTest do
  it 'has a version number' do
    expect(BankTest::VERSION).not_to be nil
  end

  it 'check transfer agent' do
    jim = BankTest::Holder.new("Jim")
    emma = BankTest::Holder.new("Emma")
    bank1 = BankTest::Bank.new
    bank2 = BankTest::Bank.new
    sender_account = BankTest::Account.new(30000, jim, bank1)
    receiver_account = BankTest::Account.new(0, emma, bank2)
    BankTest::TransferAgent.new.transfer(sender_account, receiver_account, 20000)
    expect(sender_account.balance).to eq(9900)
    expect(receiver_account.balance).to eq(20000)
  end

  it 'check transfer agent failure' do
    jim = BankTest::Holder.new("Jim")
    emma = BankTest::Holder.new("Emma")
    bank1 = BankTest::Bank.new
    bank2 = BankTest::Bank.new
    sender_account = BankTest::Account.new(20010, jim, bank1)
    receiver_account = BankTest::Account.new(0, emma, bank2)
    expect{BankTest::TransferAgent.new.transfer(sender_account, receiver_account, 20000)}.to raise_error('Error::NotEnoughMoney')
    expect(sender_account.balance).to eq(20010)
    expect(receiver_account.balance).to eq(0)
  end

  it 'check intra bank transfers' do
    jim = BankTest::Holder.new("Jim")
    emma = BankTest::Holder.new("Emma")
    bank1 = BankTest::Bank.new
    sender_account = BankTest::Account.new(30000, jim, bank1)
    receiver_account = BankTest::Account.new(0, emma, bank1)
    BankTest::TransferAgent.new.transfer(sender_account, receiver_account, 20000)
    expect(sender_account.balance).to eq(10000)
    expect(receiver_account.balance).to eq(20000)
  end

  it 'check inter bank transfers' do
    jim = BankTest::Holder.new("Jim")
    emma = BankTest::Holder.new("Emma")
    bank1 = BankTest::Bank.new
    bank2 = BankTest::Bank.new
    sender_account = BankTest::Account.new(30000, jim, bank1)
    receiver_account = BankTest::Account.new(0, emma, bank2)
    bank1.make_transfer(sender_account, receiver_account, 100)
    expect(sender_account.balance).to eq(29895)
    expect(receiver_account.balance).to eq(100)
    expect{bank1.make_transfer(sender_account, receiver_account, 2000)}.to raise_error('Error::NotValidAmount')
    expect{bank1.make_transfer(sender_account, receiver_account, 100000)}.to raise_error('Error::NotEnoughMoney')
  end
end
