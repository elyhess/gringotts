class Bank
  attr_reader :name
  attr_accessor :balance

  def initialize(name)
    @name = name
    @balance = 0
  end

  def balance
    @balance
  end

  def open_account(person)
    person.banks << self
    "An account has been opened for #{person.name} with #{name}."
  end

  def deposit(person, cash)
    if person.banks.include?(self) == true
      if person.cash >= cash
        person.cash = person.cash - cash
        @balance += cash
        "#{balance} galleons have been deposited into #{person.name}'s Chase account. Balance: #{@balance} Cash: #{person.cash}"
      else
        "#{person.name} does not have enough cash to perform this deposit."
      end
    else
      "#{person.name} does not have an account with #{name}"
    end
  end

  def withdrawal(person, cash)
    if person.banks.include?(self) == true
      if person.cash >= cash
        person.cash = person.cash + cash
        @balance -= cash
        "#{person.name} has withdrawn #{cash} galleons. Balance: #{balance}"
      else
        "Insufficient funds."
      end
    else
      "#{person.name} does not have an account with #{name}"
    end
  end

  def transfer(person, bank, cash)
    if person.banks.include?(self) == true
      if person.banks.include?(bank) == true
        if self.balance >= cash
          self.balance -= cash
          bank.balance = cash += bank.balance
        else
          "Insufficient funds."
        end
      end
    else
      "#{person.name} does not have an account with #{bank.name}."
    end
  end

end

# CURRENT ISSUES
# - if two people classes are created, totals for banks are not seperated.
# maybe try to change line 27         @balance += cash
# make the @balance += part go into a variable at the top of the method, fed into 0
# use balance as total_cash





#
