class Team
  attr_accessor :name, :record, :conference_standing, :rank

  TEAM_URL = "/team/_/id"
  ROSTER_URL = "/team/roster/_/id"

  def initialize(attribute_hash)

  end

  def games
    @games.freeze
  end

  # Load a team, their schedule, and roster based on base_url, team_id and URL
  # constants
  def self.load_team(base_url, team_id)


  end

end
