class ExerciseGuide::Muscle
  attr_accessor :name, :muscles_link

  @@all = []

  # turns all attributes into objects
  def initialize(attr_hash)
    attr_hash.each do |key, value|
      self.send("#{key}=", value)
    end
    @exercises = []
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
