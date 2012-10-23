class Assembly < Sequel::Model
  many_to_many :parts
end
