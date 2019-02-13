class Game
  attr_accessor :home_team, :away_team, :id, :score, :outcome, :date

  def initialize(attributes_hash)
    attributes_hash.each {|attr, val| send("{#attr}=", val)}
  end

end
