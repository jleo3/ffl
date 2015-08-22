module FFN
  class QBWorksheet < PlayerWorksheet

    def initialize(worksheet, average_draft_positions)
      @worksheet = worksheet
      @adp = average_draft_positions.select { |x| x.position == "QB" }

      @worksheet.title = "QB"
      @projections = FFNerd.draft_projections("QB")
      @headers = [
        "ID", "Player", "Team", "Completions", "Passing Yards",
        "Passing TDs", "INT", "Rush Yards", "Rush TDs",
        "Fumbles Lost", "Position Rank", "Overall Rank"
      ]
      @values = [
        :player_id, :display_name, :team, :completions,
        :passing_yards, :passing_td, :passing_int,
        :rush_yards, :rush_td, :fumbles
      ]
    end


    def populate_players
      @projections.count.times do |i|
        player = @projections[i]
        populate_stats(player, i)
        populate_ranking(player, i, 11)
      end
    end

  end
end

