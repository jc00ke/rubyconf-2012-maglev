pencil = Part.new(:name => "Pencil", :cost => @cost, :count => @count)
body = Part.new(:name => "Body", :cost => 0, :count => 1)
wood = Part.new(:name => "Pencil wood", :cost => 1, :count => 10)
graphite = Part.new(:name => "Graphite", :cost => 2, :count => 100)
eraser = Part.new(:name => "Eraser", :cost => 1, :count => 10)
fitting = Part.new(:name => "Eraser Fitting", :cost => 1, :count => 10)

body.add_components(wood, graphite, eraser, fitting)
pencil.add_component(body)
