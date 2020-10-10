class Person
  attr_reader :name, :banks
  attr_accessor :cash

  def initialize(name, cash)
    @cash = cash
    @name = name
    @banks = []
  end
end
