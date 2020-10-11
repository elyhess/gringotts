class Bank
  attr_reader :name
  attr_accessor :balance, :accounts

  def initialize(name)
    @name = name
    @balance = 0
    @accounts = Hash.new {|hash, key| hash[key] = 0}
  end

  def open_account(person)
    person.banks << self.name
    "An account has been opened for #{person.name} with #{name}."
  end


  def total_cash
    "Total Cash: #{@balance}"
  end

  def deposit(person, cash)
    if person.banks.include?(self.name) == true
      if person.cash >= cash
        person.cash = person.cash - cash
        @accounts[person] += cash
        @balance += cash
        "#{cash} galleons have been deposited into #{person.name}'s Chase account. Balance: #{@accounts[person]} Cash: #{person.cash}"
      else
        "#{person.name} does not have enough cash to perform this deposit."
      end
    else
      "#{person.name} does not have an account with #{name}"
    end
  end

  def withdrawal(person, cash)
    if person.banks.include?(self.name) == true
      if person.cash >= cash
        person.cash = person.cash + cash
        @accounts[person] -= cash
        @balance -= cash
        "#{person.name} has withdrawn #{cash} galleons. Balance: #{@accounts[person]}"
      else
        "Insufficient funds."
      end
    else
      "#{person.name} does not have an account with #{name}"
    end
  end

  def transfer(person, bank, cash)
    if person.banks.include?(self.name) == true
      if person.banks.include?(bank.name) == true
        if @accounts[person] >= cash && @balance >= cash
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
