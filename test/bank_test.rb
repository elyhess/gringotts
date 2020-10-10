require 'minitest/autorun'
require 'minitest/pride'
require './lib/bank'
require './lib/person'


class BankTest < Minitest::Test

  def setup
    @chase = Bank.new("JP Morgan Chase")
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
    assert_instance_of Bank, @person1.banks.first
  end

  def test_it_can_make_deposits_if_it_has_cash
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
    @chase.deposit(@person1, 750)

    expected = @chase.withdrawal(@person1, 250)
    result = "Minerva has withdrawn 250 galleons. Balance: 250"

    assert_equal 500, @person1.cash

    @chase.withdrawal(@person1, 25000)

    expected1 = "Insufficient funds."
    result1 = @chase.withdrawal(@person1, 25000)
  end


end
