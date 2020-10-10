class Person
  attr_reader :name, :galleons, :banks

  def initialize(name, galleons)
    @galleons = galleons
    @name = name
    @banks = []
  end
end
