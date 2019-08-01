module Memorable

  def initialize(attr_hash)
    attr_hash.each do |key, value|
      self.send("#{key}=", value)
    end
    self.save
  end

  def save
    self.class.all << self
    self
  end

end
