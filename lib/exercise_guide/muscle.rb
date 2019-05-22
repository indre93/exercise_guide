class ExerciseGuide::Muscle
  attr_accessor :name, :muscle_link
  attr_reader :exercises

  @@all = []

  def initialize(attr_hash) #turns all attributes into objects
    attr_hash.each do |key, value|
      self.send("#{key}=", value)
    end
    @exercises = []
    self.save
  end

  def save #returns the exercise instead of all the exercises
    @@all << self
    self
  end

  def self.all #class method bc class is keeping track of data we want returned
    @@all
  end

  def add_exercise(exercise)
    @exercises << exercise
    exercise_title.muscle = self
  end


end
