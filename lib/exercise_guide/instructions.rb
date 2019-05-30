class ExerciseGuide::Instructions
  attr_accessor :title, :instructions, :video_link, :exercise

  @@all = []

  # turns all attributes into objects
  def initialize(attr_hash)
    attr_hash.each do |key, value|
      self.send("#{key}=", value)
    end
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
