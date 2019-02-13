# Is this :: notation for convention or required?
class UvaBasketball::Player
  attr_accessor :name, :firstname, :lastname, :number, :position, :height, :weight, :year, :hometown

  def initialize(attributes_hash)
    attributes_hash.each {|attr, val| send("#{attr}=", val)}
  end


  def display
    puts "#{name.upcase}".colorize(:light_green)
    puts "  first name:".colorize(:light_blue) + " #{firstname}"
    puts "  last name:".colorize(:light_blue) + " #{lastname}"
    puts "  number:".colorize(:light_blue) + " #{number}"
    puts "  position:".colorize(:light_blue) + " #{position}"
    puts "  height:".colorize(:light_blue) + " #{height}"
    puts "  weight:".colorize(:light_blue) + " #{weight}"
    puts "  class:".colorize(:light_blue) + " #{year}"
    puts "  hometown:".colorize(:light_blue) + " #{hometown}"
    puts "----------------------".colorize(:green)
  end


end
