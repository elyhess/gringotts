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
    assert_equal @person1, @chase.accounts[0]
  end

  def test_it_can_make_deposits
  end

end
