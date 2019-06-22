class ExerciseGuide::Exercise
  extend Memorable::ClassMethods
  include Memorable::InstanceMethods

  attr_accessor :exercise_title, :exercise_rating, :exercises_link

  @@all = []

  def self.all
    @@all
  end

end
