class Part < Sequel::Model
  many_to_many :assemblies
end
