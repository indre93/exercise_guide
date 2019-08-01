class ExerciseGuide::Instructions
  include Memorable

  attr_accessor :title, :type, :muscle_worked, :equipment, :video_link, :instructions

  @@all = []

  def self.all
    @@all
  end
end
