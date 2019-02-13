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
      input = input.to_i

      if input == 1
        @team.display_info

      elsif input == 2
        schedule_list
        
        # Get new input for the sub-list
        list_input = gets.strip.downcase

        while list_input != "exit" 
          list_input = list_input.to_i

          if list_input > 0 && list_input < @team.games.size
            @team.games[list_input-1].display
            puts "\n-------------------------------------------\n"
          else
            puts "Please enter a valid option or type 'exit'"
            puts "\n-------------------------------------------\n"
          end
          schedule_list
          list_input = gets.strip.downcase
        end

      elsif input == 3
        @team.display_schedule

      elsif input == 4
        roster_list

        # Get new input for the sub-list
        list_input = gets.strip.downcase

        while list_input != "exit" 
          list_input = list_input.to_i

          if list_input > 0 && list_input < @team.roster.size
            @team.roster[list_input-1].display
            puts "\n-------------------------------------------\n"
          else
            puts "Please enter a valid option or type 'exit'"
            puts "\n-------------------------------------------\n"
          end
          roster_list
          list_input = gets.strip.downcase
        end

      elsif input == 5
        @team.display_roster

      else
        puts "Please enter a valid option or type 'exit'"
        puts "\n-------------------------------------------\n"
      end
      display_menu
      input = gets.strip.downcase
    end
  end

  
  def schedule_list
    puts "Please enter the number of the game you would like to see, or type 'exit':"
    puts "-------------------------------------------\n"
    @team.list_schedule
    puts "\n-------------------------------------------"
  end

  def roster_list
    puts "Please enter the number of the player you would like to see, or type 'exit':"
    puts "-------------------------------------------\n"
    @team.list_roster
    puts "-------------------------------------------\n"
  end

  def display_menu
    puts "\n"
    puts "1. Team Info"
    puts "2. Schedule List"
    puts "3. Schedule Details"
    puts "4. Roster List"
    puts "5. Roster Details"
    puts "\n-------------------------------------------\n"
    puts "Type 'exit' to quit"
    puts "-------------------------------------------\n"
  end

  def goodbye
    puts "Goodbye!"
  end




end
