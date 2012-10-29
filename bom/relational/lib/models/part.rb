require 'securerandom'

class Part < Sequel::Model
  many_to_many :assemblies

  def before_validation
    super
    @part_number ||= ::SecureRandom.hex(12)
  end
end
