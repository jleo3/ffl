module FFN
  class WRWorksheet < PlayerWorksheet

    def initialize(worksheet, average_draft_positions)
      @worksheet = worksheet
      @adp = average_draft_positions.select { |x| x.position == "WR" }

      @worksheet.title = "WR"
      @projections = FFNerd.draft_projections("WR")
      @headers = [
        "ID", "Player", "Team", "Receptions", "Receiving Yards",
        "Receiving TDs","Rush Yards", "Rush TDs",
        "Fumbles Lost",  "Overall Rank", "Position Rank"
      ]
      @values = [
        :player_id, :display_name, :team, :rec,
        :rec_yards, :rec_td, :rush_yards,
        :rush_td, :fumbles
      ]
    end

    def populate_players
      @projections.count.times do |i|
        player = @projections[i]
        populate_stats(player, i)
        populate_ranking(player, i, 10)
      end
    end

  end
end

