class Person
  attr_reader :name, :cash, :banks

  def initialize(name, cash)
    @cash = cash
    @name = name
    @banks = []
  end
end
