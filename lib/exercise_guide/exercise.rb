class ExerciseGuide::Exercise
  attr_accessor :exercise_title, :equipment_type, :exercise_rating, :exercises_link
  attr_reader :muscle

  @@all = []

  # turns all attributes into objects
  def initialize(attr_hash, muscle = nil)
    attr_hash.each do |key, value|
      self.send("#{key}=", value)
    end
    self.muscle = muscle if muscle
    @@all << self
  end

  # class method bc class is keeping track of data we want returned
  def self.all
    @@all
  end

  def self.destroy_all
    @@all.clear
  end

  # exercise belong to a muscle
  # adds exercise to a muscle is done by calling #add_song method on an instance of the Muscle class
  def muscle=(muscle)
    @muscle = muscle
    muscle.add_exercise(self)
  end

end
