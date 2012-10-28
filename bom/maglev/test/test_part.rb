require 'test/unit'
require File.expand_path('../../part.rb', __FILE__)

class TestPart < Test::Unit::TestCase
  def setup
    @cost = 10
    @count = 1
    @pencil = Part.new({
      :name => "Pencil",
      :cost => @cost,
      :count => @count,
    })
    @eraser = Part.new({
      :name => "Eraser",
      :cost => 1,
      :count => 10
    })
  end

  def test_initialization
    assert_not_nil @pencil.part_number
    assert_equal @cost, @pencil.cost
    assert_equal @count, @pencil.count
    assert_equal Hash.new, @pencil.components
    assert_equal Set.new, @pencil.where_used
  end

  def test_adding_component
    @pencil.add_component @eraser
    assert @pencil.components.include?(@eraser)
    assert @eraser.where_used.include?(@pencil)
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
    assert 2, @pencil.quantity_of(@eraser)
  end
end
