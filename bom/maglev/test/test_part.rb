require 'test/unit'
require File.expand_path('../../part.rb', __FILE__)

class TestPart < Test::Unit::TestCase
  def setup
    @cost = 10
    @count = 1
    @pencil = Part.new(:name => "Pencil", :cost => @cost, :count => @count)
    @body = Part.new(:name => "Body", :cost => 0, :count => 1)
    @wood = Part.new(:name => "Pencil wood", :cost => 1, :count => 10)
    @graphite = Part.new(:name => "Graphite", :cost => 2, :count => 100)
    @eraser = Part.new(:name => "Eraser", :cost => 1, :count => 10)
    @fitting = Part.new(:name => "Eraser Fitting", :cost => 1, :count => 10)
  end

  def test_initialization
    assert_not_nil @pencil.part_number
    assert_equal @cost, @pencil.cost
    assert_equal @count, @pencil.count
    assert @pencil.components.empty?
    assert @pencil.where_used.empty?
  end

  def test_adding_component
    pen = Part.new(:name => "Pen", :cost => 4, :count => 4)

    @pencil.add_component @eraser
    pen.add_component @eraser

    assert @pencil.components.include?(@eraser)
    assert pen.components.include?(@eraser)
  end

  def test_used_in?
    pen = Part.new(:name => "Pen", :cost => 4, :count => 4)

    @pencil.add_component @eraser
    pen.add_component @eraser

    assert @eraser.used_in?(@pencil)
    assert @eraser.used_in?(pen)
  end

  def test_remove_component
    @pencil.add_component @eraser
    @pencil.remove_component @eraser

    assert !@pencil.components.include?(@eraser)
    assert !@eraser.used_in?(@pencil)
  end

  def test_quantity_of
    @pencil.add_component @eraser
    @pencil.add_component @eraser

    assert_equal 2, @pencil.quantity_of(@eraser)
  end

  def test_total_cost
    @body.add_components(@graphite, @wood, @fitting, @eraser)
    @pencil.add_component(@body)

    assert_equal 15, @pencil.total_cost
  end

  def test_print_components
    @body.add_components(@graphite, @wood, @fitting, @eraser)
    @pencil.add_component(@body)
    output = @pencil.print_components

    assert_match(/^Pencil$/, output)
    assert_match(/^-- Body$/, output)
    assert_match(/^---- Graphite$/, output)
  end
end
