class ExerciseGuide::Instructions
  extend Memorable::ClassMethods
  include Memorable::InstanceMethods

  attr_accessor :title, :type, :muscle_worked, :equipment, :video_link, :instructions

  @@all = []

  def self.all
    @@all
  end

end
