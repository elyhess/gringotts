class Bank
  attr_reader :name, :accounts

  def initialize(name)
    @name = name
    @accounts = []
  end

  def open_account(person)
    @accounts << person
    person.banks << name
    "An account has been opened for #{person.name} with #{name}."
  end


end
