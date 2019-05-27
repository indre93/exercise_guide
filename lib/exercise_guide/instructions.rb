class ExerciseGuide::Instructions
  attr_accessor :title, :instructions, :video_link
  attr_reader :exercise

  @@all = []

  # turns all attributes into objects
  def initialize(attr_hash)
    attr_hash.each do |key, value|
      self.send("#{key}=", value)
    end
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

  # Belongs to - relationship
  # instruction belongs to one exercise
  def exercise=(exercise)
    @exercise = exercise
    self.exercise.exercise_title = exercise
  end

end
