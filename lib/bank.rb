class Bank
  attr_reader :name, :balance

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
    if person.cash >= cash
      person.cash = person.cash - cash
      @balance += cash
      "#{balance} galleons have been deposited into #{person.name}'s Chase account. Balance: #{@balance} Cash: #{person.cash}"
    else
      "#{person.name} does not have enough cash to perform this deposit."
    end
  end

  def withdrawal(person, cash)
    if person.cash >= cash
      person.cash = person.cash + cash
      @balance -= cash
      "#{person.name} has withdrawn #{cash} galleons. Balance: #{balance}"
    else
      "Insufficient funds."
    end
  end


end
