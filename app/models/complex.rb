class Complex < ActiveRecord::Base
  
  
  def ==(other)
    self.title == other.title
  end
  
end
