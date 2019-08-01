class ExerciseGuide::Exercise
  include Memorable

  attr_accessor :exercise_title, :exercise_rating, :exercises_link

  @@all = []

  def self.all
    @@all
  end
end
