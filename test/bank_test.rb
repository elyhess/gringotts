require 'minitest/autorun'  # => true
require 'minitest/pride'    # => true
require '../lib/bank'       # => true
require '../lib/person'     # => true


class BankTest < Minitest::Test  # => Minitest::Test

  def setup
    @chase = Bank.new("JP Morgan Chase")    # => #<Bank:0x00007fde910754c8 @name="JP Morgan Chase", @balance=0>,      #<Bank:0x00007fde9106ff00 @name="JP Morgan Chase", @balance=0>,      #<Bank:0x00007fde9106cb70 @name="JP Morgan Chase", @balance=0>,      #<Bank:0x00007fde91066068 @name="JP Morgan Chase", @balance=0>,      #<Bank:0x00007fde91064a38 @name="JP Morgan Chase", @balance=0>,      #<Bank:0x00007fde910550d8 @name="JP Morgan Chase", @balance=0>
    @wells_fargo = Bank.new("Wells Fargo")  # => #<Bank:0x00007fde910750b8 @name="Wells Fargo", @balance=0>,          #<Bank:0x00007fde9106fbe0 @name="Wells Fargo", @balance=0>,          #<Bank:0x00007fde9106c878 @name="Wells Fargo", @balance=0>,          #<Bank:0x00007fde91065d48 @name="Wells Fargo", @balance=0>,          #<Bank:0x00007fde91064768 @name="Wells Fargo", @balance=0>,          #<Bank:0x00007fde91054e58 @name="Wells Fargo", @balance=0>
    @person1 = Person.new("Minerva", 1000)  # => #<Person:0x00007fde91074de8 @cash=1000, @name="Minerva", @banks=[]>, #<Person:0x00007fde9106f938 @cash=1000, @name="Minerva", @banks=[]>, #<Person:0x00007fde9106c5d0 @cash=1000, @name="Minerva", @banks=[]>, #<Person:0x00007fde91065a78 @cash=1000, @name="Minerva", @banks=[]>, #<Person:0x00007fde91064498 @cash=1000, @name="Minerva", @banks=[]>, #<Person:0x00007fde91054bd8 @cash=1000, @name="Minerva", @banks=[]>

  end  # => :setup

  def test_it_exists_and_has_attributes

    assert_instance_of Bank, @chase              # => true
    assert_equal "JP Morgan Chase", @chase.name  # => true
  end                                            # => :test_it_exists_and_has_attributes

  def test_it_can_open_account
    expected = "An account has been opened for Minerva with JP Morgan Chase."  # => "An account has been opened for Minerva with JP Morgan Chase."
    actual =  @chase.open_account(@person1)                                    # => "An account has been opened for Minerva with JP Morgan Chase."

    assert_equal expected, actual                  # => true
    assert_instance_of Bank, @person1.banks.first  # => true
  end                                              # => :test_it_can_open_account

  def test_it_can_make_deposits_if_it_has_cash
    @chase.open_account(@person1)               # => "An account has been opened for Minerva with JP Morgan Chase."

    expected = "750 galleons have been deposited into Minerva's Chase account. Balance: 750 Cash: 250"  # => "750 galleons have been deposited into Minerva's Chase account. Balance: 750 Cash: 250"
    actual = @chase.deposit(@person1, 750)                                                              # => "750 galleons have been deposited into Minerva's Chase account. Balance: 750 Cash: 250"

    assert_equal 250, @person1.cash   # => true
    assert_equal 750, @chase.balance  # => true
    assert_equal expected, actual     # => true

    expected1 = "Minerva does not have enough cash to perform this deposit."  # => "Minerva does not have enough cash to perform this deposit."
    actual1 = @chase.deposit(@person1, 5000)                                  # => "Minerva does not have enough cash to perform this deposit."

    assert_equal 250, @person1.cash   # => true
    assert_equal 750, @chase.balance  # => true
    assert_equal expected1, actual1   # => true
  end                                 # => :test_it_can_make_deposits_if_it_has_cash

  def test_it_can_withdrawal_if_it_has_cash
    @chase.open_account(@person1)            # => "An account has been opened for Minerva with JP Morgan Chase."
    @chase.deposit(@person1, 750)            # => "750 galleons have been deposited into Minerva's Chase account. Balance: 750 Cash: 250"

    expected = @chase.withdrawal(@person1, 250)                  # => "Minerva has withdrawn 250 galleons. Balance: 500"
    result = "Minerva has withdrawn 250 galleons. Balance: 250"  # => "Minerva has withdrawn 250 galleons. Balance: 250"

    assert_equal 500, @person1.cash  # => true

    @chase.withdrawal(@person1, 25000)  # => "Insufficient funds."

    expected1 = "Insufficient funds."             # => "Insufficient funds."
    result1 = @chase.withdrawal(@person1, 25000)  # => "Insufficient funds."
  end                                             # => :test_it_can_withdrawal_if_it_has_cash

  def test_it_can_transfer_to_diff_bank
    @wells_fargo.open_account(@person1)           # => "An account has been opened for Minerva with Wells Fargo."
    @chase.open_account(@person1)                 # => "An account has been opened for Minerva with JP Morgan Chase."
    @chase.deposit(@person1, 500)                 # => "500 galleons have been deposited into Minerva's Chase account. Balance: 500 Cash: 500"
    @wells_fargo.deposit(@person1, 500)           # => "500 galleons have been deposited into Minerva's Chase account. Balance: 500 Cash: 0"
    @chase.transfer(@person1, @wells_fargo, 250)  # => 750

    assert_equal 0, @person1.cash           # => true
    assert_equal 750, @wells_fargo.balance  # => true
    assert_equal 250, @chase.balance        # => true

    @wells_fargo.transfer(@person1, @chase, 100)  # => 350

    assert_equal 0, @person1.cash           # => true
    assert_equal 650, @wells_fargo.balance  # => true
    assert_equal 350, @chase.balance        # => true
  end                                       # => :test_it_can_transfer_to_diff_bank

  def test_can_only_transfer_if_have_funds
    @wells_fargo.open_account(@person1)     # => "An account has been opened for Minerva with Wells Fargo."
    @chase.open_account(@person1)           # => "An account has been opened for Minerva with JP Morgan Chase."
    @chase.deposit(@person1, 500)           # => "500 galleons have been deposited into Minerva's Chase account. Balance: 500 Cash: 500"
    @wells_fargo.deposit(@person1, 500)     # => "500 galleons have been deposited into Minerva's Chase account. Balance: 500 Cash: 0"

    results = @chase.transfer(@person1, @wells_fargo, 1000)  # => "Insufficient funds."
    expected = "Insufficient funds."                         # => "Insufficient funds."
    @person2 = Person.new("jake", 99999)                     # => #<Person:0x00007fde910571f8 @cash=99999, @name="jake", @banks=[]>


    @wells_fargo.open_account(@person2)    # => "An account has been opened for jake with Wells Fargo."
    @person2                               # => #<Person:0x00007fde910571f8 @cash=99999, @name="jake", @banks=[#<Bank:0x00007fde91064768 @name="Wells Fargo", @balance=500>]>
    @person1                               # => #<Person:0x00007fde91064498 @cash=0, @name="Minerva", @banks=[#<Bank:0x00007fde91064768 @name="Wells Fargo", @balance=500>, #<Bank:0x00007fde91064a38 @name="JP Morgan Chase", @balance=500>]>
    @wells_fargo.deposit(@person2, 99999)  # => "100499 galleons have been deposited into jake's Chase account. Balance: 100499 Cash: 0"

    @wells_fargo.balance  # => 100499

    assert_equal expected, results  # => true
  end                               # => :test_can_only_transfer_if_have_funds


end  # => :test_can_only_transfer_if_have_funds

# >> Run options: --seed 40800
# >>
# >> # Running:
# >>
# >> ......
# >>
# >> Finished in 0.001335s, 4494.3821 runs/s, 13483.1463 assertions/s.
# >>
# >> 6 runs, 18 assertions, 0 failures, 0 errors, 0 skips
