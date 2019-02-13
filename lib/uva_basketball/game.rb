class UvaBasketball::Game
  attr_accessor :team, :opponent, :team_url, :score, :outcome, :date, :time
  @@all = []

  def initialize(attributes_hash)
    attributes_hash.each {|attr, val| send("#{attr}=", val)}
    @@all << self
  end

  def display
    puts "#{opponent}".colorize(:light_green)
    puts "  date: ".colorize(:light_blue) + "#{date}" unless date.nil? || date.empty?
    puts "  time: ".colorize(:light_blue) + "#{time}" unless time.nil? || time.empty?
    puts "  outcome: ".colorize(:light_blue) + "#{outcome}" unless outcome.nil? || outcome.empty?
    puts "  score: ".colorize(:light_blue) + "#{score}" unless score.nil? || score.empty?
    puts "----------------------".colorize(:green)
  end

end
