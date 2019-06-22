class ExerciseGuide::Muscle
  extend Memorable::ClassMethods
  include Memorable::InstanceMethods

  attr_accessor :name, :muscles_link

  @@all = []

  def self.all
    @@all
  end

end
