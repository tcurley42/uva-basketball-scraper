class Player
  attr_accessor :firstname, :lastname, :number, :position, :height, :weight, :class, :hometown

  def initialize(attributes_hash)
    attributes_hash.each {|attr, val| send("{#attr}=", val)}
  end


end
