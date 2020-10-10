require 'minitest/autorun'
require 'minitest/pride'
require './lib/person'
require './lib/bank'


class PersonTest < Minitest::Test

  def setup
    @person1 = Person.new("Minerva", 1000)
  end

  def test_it_exists_and_has_attributes

    assert_instance_of Person, @person1
    assert_equal "Minerva", @person1.name
    assert_equal 1000, @person1.galleons
    assert_equal [], @person1.banks
  end

end
