# frozen_string_literal: true

require 'set'

require_relative 'class_attribute/version'

# Inheritable class level variable accessors.
#
# @author Luca Guidi
# @author Tobias Sandelius <tobias@sandeli.us>
#
# @see ClassAttribute::ClassMethods#class_attribute
module ClassAttribute
  # @private
  # @see http://www.ruby-doc.org/core/Module.html#method-i-included
  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods # :nodoc:
    # Sets a class level attr_accessor(s) for the given attribute(s).
    #
    # @example
    #   require 'class_attribute'
    #
    #   class Animal
    #     include ClassAttribute
    #
    #     class_attribute :legs, :tail
    #
    #     self.legs = 0
    #     self.tail = false
    #   end
    #
    #   class Dog < Animal
    #     self.legs = 4
    #     self.tail = true
    #   end
    #
    #   class Chicken < Animal
    #     self.legs = 2
    #   end
    #
    #   class Snake < Animal
    #   end
    #
    #   Dog.legs     # => 4
    #   Chicken.legs # => 2
    #   Snake.legs   # => 0
    #
    #   Dog.tail      # => true
    #   Chicken.tails # => false
    #   Snake.tail    # => false
    #
    # @param attr    [Symbol] Name of the attribute to be set.
    # @param default [mixed]  Attribute default value (optional).
    #
    # @return [void]
    def class_attribute(*attrs)
      singleton_class.class_eval do
        attr_accessor(*attrs)
      end

      class_attributes.merge(attrs)
    end

  protected

    # @private
    # @see http://ruby-doc.org/core/Class.html#method-i-inherited
    def inherited(subclass)
      class_attributes.each do |attr|
        value = send(attr)
        value = value.dup rescue value
        subclass.class_attribute attr
        subclass.send("#{attr}=", value)
      end

      super
    end

  private

    # @private
    def class_attributes
      @class_attributes ||= ::Set.new
    end
  end
end
