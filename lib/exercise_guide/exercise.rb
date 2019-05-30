class ExerciseGuide::Exercise
  attr_accessor :exercise_title, :equipment_type, :exercise_rating, :exercises_link, :instructions

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

end
