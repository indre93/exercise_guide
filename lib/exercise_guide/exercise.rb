class ExerciseGuide::Exercise
  attr_accessor :exercise_title, :exercise_rating, :exercises_link, :muscle

  @@all = []

  # turns all attributes into objects
  def initialize(attr_hash, muscle = nil)
    attr_hash.each do |key, value|
      self.send("#{key}=", value)
    end
    self.muscle = muscle
    self.save
  end

  def save
    @@all << self
    self
  end

  def self.all
    @@all
  end

  def self.destroy_all
    @@all.clear
  end

end
