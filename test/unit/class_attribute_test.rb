require 'test_helper'

class Animal
  include ClassAttribute
  class_attribute :legs, :tail
  self.legs = 0
  self.tail = false
end

class Dog < Animal
  self.legs = 4
  self.tail = true
end

class Chicken < Animal
  self.legs = 2
end

class Snake < Animal ; end

describe ClassAttribute do
  describe '.class_attribute' do
    it 'defines attr_accessor at class level' do
      Dog.legs.must_equal(4)
      Chicken.legs.must_equal(2)
      Snake.legs.must_equal(0)

      Dog.tail.must_equal(true)
      Chicken.tail.must_equal(false)
      Snake.tail.must_equal(false)
    end
  end
end
