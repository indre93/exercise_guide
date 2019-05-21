class ExerciseGuide::Exercise
  attr_accessor :exercise_title, :equipment_type, :rating, :link

  @@all = []

  def initialize(attr_hash) #turns all attributes into objects
    attr_hash.each do |key, value|
      self.send("#{key}=", value)
    end
    self.save
  end

  def save #returns the exercise instead of all the exercises
    @@all << self
    self
  end

  def self.all #class method bc class is keeping track of data we want returned
    @@all
  end

  def exercise_detail

  end


end
