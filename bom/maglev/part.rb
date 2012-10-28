require 'securerandom'
require 'set'

class Part
  attr_accessor :name, :description, :cost, :count
  attr_reader :part_number, :components, :where_used

  def initialize(opts)
    @name = opts.fetch(:name)
    @description = opts.fetch(:description) {
      "Default part description for #@name"
    }
    @cost = opts.fetch(:cost)
    @count = opts.fetch(:count) { 0 }
    generate_part_number
    @components = Hash.new(0)
    @where_used = Set.new
  end

  def add_component(part)
    @components[part] += 1
    part.used_in self
  end

  def remove_component(part)
    @components.delete(part)
    part.remove_from(self)
  end

  def used_in?(part)
    @where_used.include?(part)
  end

  def quantity_of(part)
    @components.fetch(part) { 0 }
  end

  def total_cost
    @cost + @components.inject(0) { |amount, component|
      amount += component.total_cost if component.respond_to?(:total_cost)
      amount
    }
  end

  protected
  def used_in(part)
    @where_used << part
  end

  def remove_from(part)
    @where_used.delete(part)
  end

  private
  def generate_part_number
    @part_number ||= SecureRandom.hex(12)
  end
end
