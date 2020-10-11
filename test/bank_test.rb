require 'minitest/autorun'
require 'minitest/pride'
require './lib/bank'
require './lib/person'


class BankTest < Minitest::Test

  def setup
    @chase = Bank.new("JP Morgan Chase")
    @wells_fargo = Bank.new("Wells Fargo")
    @person1 = Person.new("Minerva", 1000)

  end

  def test_it_exists_and_has_attributes

    assert_instance_of Bank, @chase
    assert_equal "JP Morgan Chase", @chase.name
  end

  def test_it_can_open_account
    expected = "An account has been opened for Minerva with JP Morgan Chase."
    actual =  @chase.open_account(@person1)

    assert_equal expected, actual
    assert_equal true, @person1.banks.include?("JP Morgan Chase")
  end

  def test_it_can_make_deposits_if_it_has_cash
    @chase.open_account(@person1)

    expected = "750 galleons have been deposited into Minerva's Chase account. Balance: 750 Cash: 250"
    actual = @chase.deposit(@person1, 750)

    assert_equal 250, @person1.cash
    assert_equal 750, @chase.balance
    assert_equal expected, actual

    expected1 = "Minerva does not have enough cash to perform this deposit."
    actual1 = @chase.deposit(@person1, 5000)

    assert_equal 250, @person1.cash
    assert_equal 750, @chase.balance
    assert_equal expected1, actual1
  end

  def test_it_can_withdrawal_if_it_has_cash
    @chase.open_account(@person1)
    @chase.deposit(@person1, 750)

    expected = @chase.withdrawal(@person1, 250)
    result = "Minerva has withdrawn 250 galleons. Balance: 250"

    assert_equal 500, @person1.cash

    @chase.withdrawal(@person1, 25000)

    expected1 = "Insufficient funds."
    result1 = @chase.withdrawal(@person1, 25000)
  end

  def test_it_can_transfer_to_diff_bank
    @wells_fargo.open_account(@person1)
    @chase.open_account(@person1)
    @chase.deposit(@person1, 500)
    @wells_fargo.deposit(@person1, 500)
    @chase.transfer(@person1, @wells_fargo, 250)

    assert_equal 0, @person1.cash
    assert_equal 750, @wells_fargo.balance
    assert_equal 250, @chase.balance

    @wells_fargo.transfer(@person1, @chase, 100)

    assert_equal 0, @person1.cash
    assert_equal 650, @wells_fargo.balance
    assert_equal 350, @chase.balance
  end

  def test_can_only_transfer_if_have_funds
    @wells_fargo.open_account(@person1)
    @chase.open_account(@person1)

    @chase.deposit(@person1, 500)
    @wells_fargo.deposit(@person1, 500)

    results = @chase.transfer(@person1, @wells_fargo, 1000)
    expected = "Insufficient funds."

    assert_equal expected, results
  end

  def test_it_gives_total
    @person2 = Person.new("John", 1000)
    @wells_fargo.open_account(@person1)
    @chase.open_account(@person1)
    @wells_fargo.open_account(@person2)
    @chase.open_account(@person2)

    @chase.deposit(@person1, 500)
    @wells_fargo.deposit(@person1, 500)

    @chase.deposit(@person2, 100)
    @wells_fargo.deposit(@person2, 300)

    @chase.accounts

    @chase.transfer(@person1, @wells_fargo, 250)
    @wells_fargo.transfer(@person2, @chase, 100)

    @chase.balance
    @wells_fargo.balance

    assert_equal 0, @person1.cash
    assert_equal 950, @wells_fargo.balance
    assert_equal 450, @chase.balance

    assert_equal "Total Cash: 450", @chase.total_cash
    assert_equal "Total Cash: 950", @wells_fargo.total_cash
  end


end
