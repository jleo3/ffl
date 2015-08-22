module FFN
  class RBWorksheet < PlayerWorksheet

    def initialize(worksheet, average_draft_positions)
      @worksheet = worksheet
      @adp = average_draft_positions.select { |x| x.position == "RB" }

      @worksheet.title = "RB"
      @projections = FFNerd.draft_projections("RB")
      @headers = [
        "ID", "Player", "Team", "Rush Yards", "Rush TDs",
        "Fumbles Lost", "Receptions", "Receiving Yards",
        "Receiving TDs", "Position Rank", "Overall Rank"
      ]
      @values = [
        :player_id, :display_name, :team, :rush_yards,
        :rush_td, :fumbles, :rec, :rec_yards, :rec_td
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

