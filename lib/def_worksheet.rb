module FFN
  class DEFWorksheet < PlayerWorksheet

    def initialize(worksheet, average_draft_positions)
      @worksheet = worksheet
      @adp = average_draft_positions.select { |x| x.position == "DEF" }

      @worksheet.title = "DEF"
      @projections = FFNerd.draft_projections("DEF")
      @headers = [
        "ID", "Player", "Team",
        "Sacks", "INT", "Fumble Rec", "TDs",
        "Overall Rank", "Position Rank"
      ]
      @values = [
        :player_id, :display_name, :team,
        :sacks, :interceptions, :fumble_rec, :td
      ]
    end

    def populate_players
      @projections.count.times do |i|
        player = @projections[i]
        populate_stats(player, i)
        populate_ranking(player, i, 8)
      end
    end

  end
end

