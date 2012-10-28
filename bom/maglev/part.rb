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
    @components = Set.new
    @where_used = Set.new
  end

  def add_component(part)
    @components << part
    part.used_in self
  end

  def remove_component(part)
    @components.delete(part)
    part.remove_from(self)
  end

  def used_in?(part)
    @where_used.include?(part)
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
