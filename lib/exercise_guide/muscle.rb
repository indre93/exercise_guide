class ExerciseGuide::Muscle
  include Memorable

  attr_accessor :name, :muscles_link

  @@all = []

  def self.all
    @@all
  end
end
