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

  # array is frozen means you can’t change the array
  # strings in array are not frozen
  # if changes are made to one string, the new string is revealed to frozen array
  def exercises
    @exercises.dup.freeze
  end

  # is_a? is checking the class of the object
  # if a string does not come from Exercise class, raise error
  # this prevent us from manually pushing an exercise to array
  def add_exercise(exercise)
    if !exercise.is_a?(ExerciseGuide::Exercise)
      raise "Invalid type, must be an Exercise"
    else
      @exercises << exercise
    end
  end

end
