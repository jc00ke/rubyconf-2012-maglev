class Part < Sequel::Model
  many_to_many :assemblies

  def before_validation
    super
    @part_number = Faker::Base.bothify("###-#####")
  end
end
