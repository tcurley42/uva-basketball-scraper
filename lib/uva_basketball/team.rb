class UvaBasketball::Team
  attr_accessor :name, :mascot, :record, :conference_rank, :rank, :games, :roster
  # Do I need to specify readers for games/roster to return list.freeze?

  # URL Constants
  TEAM_URL = "/team/_/id"
  ROSTER_URL = "/team/roster/_/id"

  # Schedule CSS Selectors
  CSS_LOCATION = "span.ClubhouseHeader__Location"
  CSS_DISPLAY_NAME = "span.ClubhouseHeader__DisplayName"
  CSS_RANK = "span.ClubhouseHeader__Rank"
  CSS_TEAM_DETAILS = "div.ClubhouseHeader__TeamDetails"
  CSS_RECORD = "ul.ClubhouseHeader__Record li"
  CSS_SCHEDULE = "section.club-schedule ul li"
  CSS_GAME_INFO = "div.game-info"
  CSS_GAME_META = "div.game-meta"
  CSS_GAME_RESULT = "div.game-result"
  CSS_GAME_SCORE = "div.score"
  CSS_DATE = "div.game-date span"
  CSS_TIME = "div.time"

  # Roster CSS Selectors
  CSS_ROSTER_TABLE = ".Team.Roster tbody.Table2__tbody tr"
  CSS_PLAYER_ROW = "td span"


  @@all = []

  def initialize(attribute_hash)
    attribute_hash.each {|attr, val| send("#{attr}=", val)}
    @@all << self
  end

  def display_info
    puts "#{name.upcase} #{mascot.upcase}".colorize(:blue)
    puts "  rank: ".colorize(:light_blue) + "#{rank}"
    puts "  record: ".colorize(:light_blue) + "#{record}"
    puts "  conference rank: ".colorize(:light_blue) + "#{conference_rank}"
  end

  def display_schedule
    games.each {|game|
      game.display
    }
  end

  def display_roster
    roster.each {|player|
      player.display
    }
  end
  # Load a team, their schedule, and roster based on base_url, team_id and URL
  # constants
  def self.load_team(base_url, team_id)
    # Load schedule and team details
    team_url = base_url + TEAM_URL + team_id
    schedule_hash = load_schedule(team_url)

    # Load roster
    roster_url = base_url + ROSTER_URL + team_id
    roster_hash = load_roster(roster_url)

    # Merge the hashes into one and create the team
    team = UvaBasketball::Team.new(schedule_hash.merge(roster_hash))

  end

  def self.load_schedule(url)
    doc = Nokogiri::HTML(open(url))

    team_details = doc.css(CSS_TEAM_DETAILS + " " + CSS_RECORD)

    # Load the team details
    schedule_hash = {
      name: doc.css(CSS_LOCATION).text,
      mascot: doc.css(CSS_DISPLAY_NAME).text,
      rank: doc.css(CSS_RANK).text,
      record: team_details.first.text,
      conference_rank: team_details.last.text
    }

    games = []

    # Load the schedule of all games
    schedule = doc.css(CSS_SCHEDULE)

    schedule.each {|game|
      game_hash = {
        opponent: game.css(CSS_GAME_INFO).text,
        team_url: game.css("a").attribute("href").value,
        outcome: game.css(CSS_GAME_META + " " + CSS_GAME_RESULT).text,
        score: game.css(CSS_GAME_META + " " + CSS_GAME_SCORE).text,
        date: game.css(CSS_GAME_META + " " + CSS_DATE).text,
        time: game.css(CSS_GAME_META + " " + CSS_TIME).text
      }
      game = UvaBasketball::Game.new(game_hash)
      games << game
    }

    schedule_hash[:games] = games
    schedule_hash
  end

  def self.load_roster(url)
    doc = Nokogiri::HTML(open(url))

    roster_hash = {}

    player_list = doc.css(CSS_ROSTER_TABLE)

    players = player_list.collect {|player|
      attrs = player.css(CSS_PLAYER_ROW)

      # Get the second `a` tag because the first does not contain the player
      # name
      full_name = attrs.css("a")[1].text

      player_hash = {
        name: full_name,
        number: attrs[2].text,
        firstname: full_name.split(" ").first,
        lastname: full_name.split(" ").last,
        position: attrs[3].text,
        height: attrs[4].text,
        weight: attrs[5].text,
        year: attrs[6].text,
        hometown: attrs[7].text
      }
      player = UvaBasketball::Player.new(player_hash)
    }

    roster_hash[:roster] = players
    roster_hash
  end

end
