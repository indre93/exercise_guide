module Memorable
  module ClassMethods
    def destroy_all
      self.all.clear
    end
  end

  module InstanceMethods
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
end
