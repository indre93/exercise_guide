class ExerciseGuide::Muscle
  attr_accessor :name, :muscles_link
  attr_reader :exercises

  @@all = []

  # turns all attributes into objects
  def initialize(attr_hash)
    attr_hash.each do |key, value|
      self.send("#{key}=", value)
    end
    @exercises = []
    self.save
  end

  # returns the exercise instead of all the exercises
  def save
    @@all << self
    self
  end

  # class method bc class is keeping track of data we want returned
  def self.all
    @@all
  end

  def self.destroy_all
    @@all.clear
  end

  # Has many object - relationship
  # muscle has many exercises
  def add_exercise(exercise)
    @exercises << exercise
    exercise.muscle = self
  end

end
