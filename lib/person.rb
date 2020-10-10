class Person
  attr_reader :name, :galleons

  def initialize(name, galleons)
    @galleons = galleons
    @name = name
  end
end
