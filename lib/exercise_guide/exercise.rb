class ExerciseGuide::Exercise
  attr_accessor :exercise_title, :equipment_type, :exercise_rating, :exercises_link
  attr_reader :muscle, :instruction

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
  # exercises belong to a Muscle
  # adds an exercise to a muscle by calling an #add_song method on an instance of the Artist class
  def muscle=(muscle)
    @muscle = muscle
    muscle.add_exercise(self)
  end

  # Belongs to - relationship
  # exercises have one instruction
  def instruction=(instruction)
    @instruction = instruction
    self.instructions.instructions = instruction
  end

end
