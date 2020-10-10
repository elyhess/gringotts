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
    person.cash = person.cash - cash
    @balance += cash
  end


end
