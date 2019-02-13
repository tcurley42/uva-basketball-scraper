class UvaBasketball::CLI
  
  BASE_URL = "http://www.espn.com"
  SPORT_URL = "/mens-college-basketball"
  TEAM_ID = "/258"

  def call
    @team = UvaBasketball::Team.load_team(BASE_URL + SPORT_URL, TEAM_ID)
    menu
    goodbye
  end

  def menu
    puts "Welcome to Virginia Basketball! Please type the option you would like to see:"
    display_menu

    input = gets.strip.downcase

    while input != "exit"
      if input.to_i == 1
        @team.display_info
        puts "" 
      elsif input.to_i == 2
        @team.display_schedule
        puts ""
      elsif input.to_i == 3
        @team.display_roster
        puts ""
      else
        puts "Please enter a valid option or type 'exit'"
      end
      display_menu
      input = gets.strip.downcase
    end
  end

  def display_menu
    puts "1. Team Info"
    puts "2. Schedule"
    puts "3. Roster"
    puts "Type 'exit' to quit"
  end

  def goodbye
    puts "Goodbye!"
  end




end
