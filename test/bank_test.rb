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

  def test_it_can_make_deposits
    expected = "750 galleons have been deposited into Minerva's Chase account. Balance: 750 Cash: 250"
    actual = @chase.deposit(@person1, 750)

    assert_equal 250, @person1.cash
    assert_equal 750, @chase.balance
    assert_equal expected, actual
  end

  def test_it_cant_deposit_if_does_not_have
    expected = "Minerva does not have enough cash to perform this deposit."
    actual = @chase.deposit(@person1, 5000)

    assert_equal expected, actual
  end

  

end
